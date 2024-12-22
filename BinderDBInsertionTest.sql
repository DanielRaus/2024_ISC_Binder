-- Insert genres
INSERT INTO "genres" ("name") VALUES 
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

-- Insert languages
INSERT INTO "languages" ("name") VALUES 
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

-- Insert lengths
INSERT INTO "lengths" ("length") VALUES 
('short'),
('medium'),
('long'),
('very_long'),
('humongous');

-- Insert authors
INSERT INTO "authors" ("id", "au_fname", "au_lname") VALUES 
(1, 'J.K.', 'Rowling'),
(2, 'George', 'Orwell'),
(3, 'J.R.R.', 'Tolkien'),
(4, 'Agatha', 'Christie'),
(5, 'Isaac', 'Asimov');

-- Insert titles
INSERT INTO "titles" ("name", "pages", "price", "pubdate", "isAvailable") VALUES 
('Harry Potter and the Sorcerer''s Stone', 309, 19.99, '1997-06-26', true),
('1984', 328, 14.99, '1949-06-08', true),
('The Hobbit', 310, 15.99, '1937-09-21', true),
('Murder on the Orient Express', 256, 12.99, '1934-01-01', true),
('Foundation', 255, 18.99, '1951-06-01', true);

-- Insert titles_authors
INSERT INTO "titles_authors" ("title_id", "author_id") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert titles_genres
INSERT INTO "titles_genres" ("title_id", "genre_id") VALUES
(1, 1),  -- Harry Potter and the Sorcerer's Stone -> Fantasy
(2, 4),  -- 1984 -> Fiction
(3, 1),  -- The Hobbit -> Fantasy
(4, 10), -- Murder on the Orient Express -> Crime
(5, 3);  -- Foundation -> Science_Fiction

-- Insert titles_languages
INSERT INTO "titles_languages" ("title_id", "language_id") VALUES
(1, 17),  -- Harry Potter and the Sorcerer's Stone -> English
(2, 17),  -- 1984 -> English
(3, 17),  -- The Hobbit -> English
(4, 17),  -- Murder on the Orient Express -> English
(5, 17);  -- Foundation -> English

-- Insert users
INSERT INTO "user" ("username", "fname", "lname", "age", "gender") VALUES
('johndoe', 'John', 'Doe', 30, 'male'),
('janedoe', 'Jane', 'Doe', 28, 'female');

-- Insert language_preferences
INSERT INTO "language_preferences" ("user_id", "language_id") VALUES
(1, 17), -- John -> English
(2, 17); -- Jane -> English

-- Insert genre_preferences
INSERT INTO "genre_preferences" ("user_id", "genre_id") VALUES
(1, 1),  -- John -> Fantasy
(2, 3);  -- Jane -> Fiction

-- Insert author_preferences
INSERT INTO "author_preferences" ("user_id", "author_id") VALUES
(1, 1),  -- John -> J.K. Rowling
(2, 2);  -- Jane -> George Orwell

-- Insert length_preferences
INSERT INTO "length_preferences" ("user_id", "length_id") VALUES
(1, 3),  -- John -> long
(2, 2);  -- Jane -> medium








