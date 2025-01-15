-- Insert Sample Authors
INSERT INTO authors (au_fname, au_lname) VALUES
('J.K.', 'Rowling'),
('George', 'Orwell'),
('Jane', 'Austen'),
('Mark', 'Twain');

-- Insert Sample Titles
INSERT INTO titles (name, pages, price, pubdate, is_available, ISBN, cover_image_url, average_rating, publisher) VALUES
('Harry Potter and the Philosopher''s Stone', 223, 20.99, '1997-06-26', TRUE, '9780747532743', 'https://example.com/images/harry_potter.jpg', 4.9, 'Bloomsbury'),
('1984', 328, 15.99, '1949-06-08', TRUE, '9780451524935', 'https://example.com/images/1984.jpg', 4.7, 'Secker & Warburg'),
('Pride and Prejudice', 279, 12.99, '1813-01-28', TRUE, '9780141439518', 'https://example.com/images/pride_and_prejudice.jpg', 4.8, 'T. Egerton'),
('The Adventures of Tom Sawyer', 187, 10.99, '1876-01-01', TRUE, '9780486400778', 'https://example.com/images/tom_sawyer.jpg', 4.3, 'American Publishing Company');

-- Link Titles and Authors
INSERT INTO titles_authors (title_id, author_id) VALUES
(1, 1), -- Harry Potter by J.K. Rowling
(2, 2), -- 1984 by George Orwell
(3, 3), -- Pride and Prejudice by Jane Austen
(4, 4); -- The Adventures of Tom Sawyer by Mark Twain

-- Insert Sample Genres
INSERT INTO genres (name) VALUES
('Art'),
('Biography'),
('Business'),
('Children'),
('Christian'),
('Classics'),
('Comics'),
('Contemporary'),
('Cookbooks'),
('Crime'),
('Ebooks'),
('Fantasy'),
('Fiction'),
('Graphic_Novels'),
('Historical'),
('History'),
('Horror'),
('Comedy'),
('Manga'),
('Memoir'),
('Music'),
('Mystery'),
('Nonfiction'),
('Paranormal'),
('Philosophy'),
('Poetry'),
('Psychology'),
('Religion'),
('Romance'),
('Science'),
('Science_Fiction'),
('Self_Help'),
('Suspense'),
('Spirituality'),
('Sports'),
('Thriller'),
('Travel'),
('Young_Adult');

-- Link Titles and Genres
INSERT INTO titles_genres (title_id, genre_id) VALUES
(1, 12), -- Harry Potter is Fantasy
(2, 24), -- 1984 is Dystopian
(3, 6), -- Pride and Prejudice is Classics
(4, 34); -- The Adventures of Tom Sawyer is Adventure

-- Insert Sample Languages
INSERT INTO languages (name) VALUES
('Afrikaans'), 
('Arabic'), 
('Bengali'), 
('Bulgarian'), 
('Catalan'), 
('Cantonese'), 
('Croatian'), 
('Czech'), 
('Danish'), 
('Dutch'), 
('Lithuanian'), 
('Malay'), 
('Malayalam'), 
('Panjabi'), 
('Tamil'), 
('English'), 
('Finnish'), 
('French'), 
('German'), 
('Greek'), 
('Hebrew'), 
('Hindi'), 
('Hungarian'), 
('Indonesian'), 
('Italian'), 
('Japanese'), 
('Javanese'), 
('Korean'), 
('Norwegian'), 
('Polish'), 
('Portuguese'), 
('Romanian'), 
('Russian'), 
('Serbian'), 
('Slovak'), 
('Slovene'), 
('Spanish'), 
('Swedish'), 
('Telugu'), 
('Thai'), 
('Turkish'), 
('Ukrainian'), 
('Vietnamese'), 
('Welsh'), 
('Sign'), 
('Algerian'), 
('Aramaic'), 
('Armenian'), 
('Berber'), 
('Burmese'), 
('Bosnian'), 
('Brazilian'), 
('Cypriot'), 
('Corsica'), 
('Creole'), 
('Scottish'), 
('Egyptian'), 
('Esperanto'), 
('Estonian'), 
('Finn'), 
('Flemish'), 
('Georgian'), 
('Hawaiian'), 
('Inuit'), 
('Irish'), 
('Icelandic'), 
('Latin'), 
('Mandarin'), 
('Nepalese'), 
('Sanskrit'), 
('Tagalog'), 
('Tahitian'), 
('Tibetan'), 
('Gypsy'), 
('Wu');

-- Link Titles and Languages
INSERT INTO titles_languages (title_id, language_id) VALUES
(1, 16), -- Harry Potter in English
(2, 16), -- 1984 in English
(3, 16), -- Pride and Prejudice in English
(4, 16); -- The Adventures of Tom Sawyer in English

-- Insert Sample Users
INSERT INTO users (username, fname, lname, age, gender, location, password_hash, profile_picture_url) VALUES
('booklover1', 'Alice', 'Smith', 30, 'female', 'New York', 'hash1', 'https://example.com/images/alice.jpg'),
('bookworm', 'Bob', 'Johnson', 25, 'male', 'San Francisco', 'hash2', 'https://example.com/images/bob.jpg');

-- Insert User Preferences (Languages)
INSERT INTO language_preferences (user_id, language_id) VALUES
(1, 16), -- Alice prefers English
(2, 16); -- Bob prefers English

-- Insert User Preferences (Genres)
INSERT INTO genre_preferences (user_id, genre_id) VALUES
(1, 12), -- Alice prefers Fantasy
(2, 24); -- Bob prefers Dystopian

-- Insert User Preferences (Authors)
INSERT INTO author_preferences (user_id, author_id) VALUES
(1, 1), -- Alice prefers J.K. Rowling
(2, 2); -- Bob prefers George Orwell

-- Insert Lengths
INSERT INTO lengths (length) VALUES
('short'), 
('medium'), 
('long'), 
('very_long'), 
('humongous');

-- Insert User Preferences (Lengths)
INSERT INTO length_preferences (user_id, length_id) VALUES
(1, 3), -- Alice prefers long books
(2, 2); -- Bob prefers medium books

-- Insert Formats
INSERT INTO formats (type) VALUES
('hardcover'), 
('ebook'), 
('audiobook'), 
('paperback');

-- Link Titles and Formats
INSERT INTO titles_formats (title_id, format_id) VALUES
(1, 1), -- Harry Potter in hardcover
(2, 4); -- 1984 in paperback

-- Insert Liked Titles
INSERT INTO liked_titles (user_id, title_id) VALUES
(1, 1), -- Alice likes Harry Potter
(2, 2), -- Bob likes 1984
(1, 3); -- Alice also likes Pride and Prejudice