const express = require("express");
const app = express();
const cors = require('cors');
const { Client } = require('pg');
const { sha256 } = require("pg/lib/crypto/utils-legacy.js");

// Database configuration
const db = new Client({
    host: "localhost",
    user: "postgres",
    password: "myverysecretpassword",
    database: "BinderDBTest",
    port: 5432,
});

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Database connection
db.connect()
.then(() => console.log("Connected to database successfully"))
.catch(err => {
    console.error("Database connection error:", err);
    process.exit(1);
});

// Routes
app.get("/", (req, res) => {
    res.json({ message: "Server is running" });
});

app.post("/login", async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username || !password) {
            return res.status(400).json({
                success: false,
                message: "Username and password are required"
            });
        }

        const userQuery = 'SELECT * FROM users WHERE username = $1';
        const userResult = await db.query(userQuery, [username]);

        if (userResult.rows.length === 0) {
            return res.status(401).json({
                success: false,
                message: "User not found"
            });
        }

        const user = userResult.rows[0];
        const hashedPassword = sha256(password).toString('hex');

        if (hashedPassword === user.password_hash) {
            const { password_hash, ...userData } = user;
            res.json({
                success: true,
                user: userData
            });
        } else {
            res.status(401).json({
                success: false,
                message: "Invalid credentials"
            });
        }
    } catch (err) {
        console.error("Login error:", err);
        res.status(500).json({
            success: false,
            message: "Server error"
        });
    }
});

app.post("/signup", async (req, res) => {
    try {
        const { username, password } = req.body;
        console.log("Received signup request for username:", username);

        if (!username || !password) {
            return res.status(400).json({
                success: false,
                message: "Username and password are required"
            });
        }

        // Check if username already exists
        const checkUser = await db.query('SELECT * FROM users WHERE username = $1', [username]);
        if (checkUser.rows.length > 0) {
            return res.status(400).json({
                success: false,
                message: "Username already exists"
            });
        }

        // Create new user
        const hashedPassword = sha256(password).toString('hex');
        const query = 'INSERT INTO users(username, password_hash) VALUES ($1, $2) RETURNING id, username';
        const result = await db.query(query, [username, hashedPassword]);

        res.json({
            success: true,
            user: result.rows[0],
            message: "User created successfully"
        });
    } catch (err) {
        console.error("Signup error:", err);
        res.status(500).json({
            success: false,
            message: "Server error during signup"
        });
    }
});

app.get("/books", async (req, res) => {
    try {
        const query = `
        SELECT
        t.id,
        t.name as title,
        t.pages,
        t.price,
        t.pubdate,
        t.is_available,
        t.ISBN as isbn,
        t.cover_image_url,
        t.average_rating,
        t.publisher,
        STRING_AGG(DISTINCT CONCAT(a.au_fname, ' ', a.au_lname), ', ') as author,
        ARRAY_TO_JSON(ARRAY_AGG(DISTINCT g.name)) as genres,
        ARRAY_TO_JSON(ARRAY_AGG(DISTINCT l.name)) as languages,
        ARRAY_TO_JSON(ARRAY_AGG(DISTINCT f.type)) as formats
        FROM titles t
        LEFT JOIN titles_authors ta ON t.id = ta.title_id
        LEFT JOIN authors a ON ta.author_id = a.id
        LEFT JOIN titles_genres tg ON t.id = tg.title_id
        LEFT JOIN genres g ON tg.genre_id = g.id
        LEFT JOIN titles_languages tl ON t.id = tl.title_id
        LEFT JOIN languages l ON tl.language_id = l.id
        LEFT JOIN titles_formats tf ON t.id = tf.title_id
        LEFT JOIN formats f ON tf.format_id = f.id
        WHERE t.is_available = true
        GROUP BY t.id
        ORDER BY t.id;
        `;

        const result = await db.query(query);
        res.json({
            success: true,
            books: result.rows
        });
    } catch (err) {
        console.error("Error fetching books:", err);
        res.status(500).json({
            success: false,
            message: "Error fetching books"
        });
    }
});

// Utility Functions
async function getPassword(username) {
    try {
        const query = 'SELECT password_hash FROM users WHERE username = $1';
        const result = await db.query(query, [username]);
        if (result.rows.length === 0) throw new Error('User not found');
        return result.rows[0].password_hash;
    } catch (err) {
        console.error("Get password error:", err);
        throw err;
    }
}

async function resetPreferences(username, genres, languages, lengths) {
    try {
        await db.query('BEGIN');

        const deleteQuery = `
        DELETE FROM genre_preferences WHERE user_id = (SELECT id FROM users WHERE username = $1);
        DELETE FROM language_preferences WHERE user_id = (SELECT id FROM users WHERE username = $1);
        DELETE FROM length_preferences WHERE user_id = (SELECT id FROM users WHERE username = $1)
        `;
        await db.query(deleteQuery, [username]);

        if (genres?.length) {
            const genreQuery = `
            INSERT INTO genre_preferences (user_id, genre_id)
            SELECT u.id, g.id FROM users u, genres g
            WHERE u.username = $1 AND g.id = ANY($2)
            `;
            await db.query(genreQuery, [username, genres]);
        }

        if (languages?.length) {
            const langQuery = `
            INSERT INTO language_preferences (user_id, language_id)
            SELECT u.id, l.id FROM users u, languages l
            WHERE u.username = $1 AND l.id = ANY($2)
            `;
            await db.query(langQuery, [username, languages]);
        }

        if (lengths?.length) {
            const lengthQuery = `
            INSERT INTO length_preferences (user_id, length_id)
            SELECT u.id, l.id FROM users u, lengths l
            WHERE u.username = $1 AND l.id = ANY($2)
            `;
            await db.query(lengthQuery, [username, lengths]);
        }

        await db.query('COMMIT');
        return true;
    } catch (err) {
        await db.query('ROLLBACK');
        console.error("Reset preferences error:", err);
        throw err;
    }
}

// Server startup
const PORT = 8080;
app.listen(PORT, '0.0.0.0')
.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error(`Port ${PORT} is already in use. Please choose a different port or kill the process using this port.`);
    } else {
        console.error('Server error:', err);
    }
    process.exit(1);
})
.on('listening', () => {
    console.log(`Server running on http://192.168.1.102:${PORT}`);
});

// Error handling for uncaught exceptions
process.on('uncaughtException', (err) => {
    console.error('Uncaught Exception:', err);
    process.exit(1);
});

process.on('unhandledRejection', (err) => {
    console.error('Unhandled Rejection:', err);
    process.exit(1);
});
