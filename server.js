const express = require("express");
const app = express();
const { Client } = require('pg');
const { sha256 } = require("pg/lib/crypto/utils-legacy.js");

const db = new Client({
  host: "localhost",
  user: "postgres",
  password: "myverysecretpassword",
  database: "BinderDBTest",
  port: 5432,
});

db.connect((err) => {
  if (err) {
    console.error("Erreur de connection à la DB", err);
    process.exit(1);
  }
  console.log("Connexion réussie à la DB");
})

// Middleware pour parser les données du corps de la requête
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Définir une route par défaut
app.get("/", (req, res) => {
  res.send("Hello, World! Le serveur Express.js fonctionne.");
});

// Route GET pour la page /login
app.get("/login", (req, res) => {
  console.log("Requête reçue pour /login");

  const query = 'SELECT * FROM authors'; // Votre requête SQL

  // Exécution de la requête SQL
  db.query(query, (err, results) => {
    if (err) {
      console.error("Erreur lors de l'exécution de la requête :", err.message);
      return res.status(500).send("Erreur serveur.");
    }

    console.log("Résultats reçus de la base de données :", results);
    res.json(results); // Envoi des résultats comme réponse JSON
  });
});

// Démarrer le serveur
const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${PORT}`);
});

// Query test
// console.log("Testing queries")
// const query = 'SELECT * FROM "users"';
// db.query(query, (err, results) => {
//   if (err) {
//     console.error("Erreur lors de queries");
//     return;
//   }
//   console.log("Query results")
//   console.table(results.rows)
// })

// =========================================
// Functions
// =========================================
/**
 * Function to create new user by adding new username and password to database
 * @param username
 * @param password
 */
async function createAccount(username, password) {
  const hashed_password = sha256(password).toString('hex');
  console.log(hashed_password);
  const query = `INSERT INTO users(username,password_hash) VALUES ('${username}','${hashed_password}');`
  console.log(query)
  db.query(query,(err) => {
    if (err) {
      throw err;
    }
    console.log("Success")
  })
}

/**
 * Function to retrieve hashed password from database
 * @param username
 * @returns {Promise<unknown>}
 */
async function getPassword(username) {
  const query = `SELECT password_hash FROM users WHERE username = $1;`;

  return new Promise((resolve, reject) => {
    db.query(query,[username], (err, results) => {
      if (err) {
        reject(err); // Reject the Promise on error
      } else {
        const rows = results.rows;
        resolve(rows[0].password_hash); // Resolve with the password hash
      }
    });
  });
}

/**
 * Function to authenticate user after retrieving password hash from database
 * @param username
 * @param inputPassword
 * @returns {Promise<void>}
 */
async function authenticate(username,inputPassword){
  const hashedInput = sha256(inputPassword).toString('hex');
  const retrievedPassword = await getPassword(username)

  if (hashedInput === retrievedPassword) {
    console.log("Authentication success")
  }
  else {
    console.log("Authentication error")
  }
}

async function resetPreferences(username,genres,languages,lengths){
  // Step1: Delete all existing queries associated to user
  const query1 =
      `DELETE FROM genre_preferences CASCADE WHERE user_id = (SELECT id FROM users WHERE username = $1);
       DELETE FROM language_preferences CASCADE WHERE user_id = (SELECT id FROM users WHERE username = $1);
       DELETE FROM length_preferences CASCADE WHERE user_id = (SELECT id FROM users WHERE username = $1)`
  db.query(query1,(err) => {
    if (err) {
      reject(err);
    }
  })

  // Step2: Insert new data
  const query2 =
      `INSERT INTO genre_preferences VALUES (${username},${genres.join("")});
       INSERT INTO language_preferences VALUES ${newLanguages}
       `
}



// Test
createAccount("JohnDoe256","password")
authenticate("JohnDoe256","password")