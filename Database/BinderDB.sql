-- Enum Types
CREATE TYPE Genre AS ENUM (
  'Art', 'Biography', 'Business', 'Children', 'Christian', 'Classics', 'Comics', 
  'Contemporary', 'Cookbooks', 'Crime', 'Ebooks', 'Fantasy', 'Fiction', 
  'Graphic_Novels', 'Historical', 'History', 'Horror', 'Comedy', 'Manga', 
  'Memoir', 'Music', 'Mystery', 'Nonfiction', 'Paranormal', 'Philosophy', 
  'Poetry', 'Psychology', 'Religion', 'Romance', 'Science', 'Science_Fiction', 
  'Self_Help', 'Suspense', 'Spirituality', 'Sports', 'Thriller', 'Travel', 
  'Young_Adult'
);

CREATE TYPE Language AS ENUM (
  'Afrikaans', 'Arabic', 'Bengali', 'Bulgarian', 'Catalan', 'Cantonese', 
  'Croatian', 'Czech', 'Danish', 'Dutch', 'Lithuanian', 'Malay', 'Malayalam', 
  'Panjabi', 'Tamil', 'English', 'Finnish', 'French', 'German', 'Greek', 
  'Hebrew', 'Hindi', 'Hungarian', 'Indonesian', 'Italian', 'Japanese', 
  'Javanese', 'Korean', 'Norwegian', 'Polish', 'Portuguese', 'Romanian', 
  'Russian', 'Serbian', 'Slovak', 'Slovene', 'Spanish', 'Swedish', 'Telugu', 
  'Thai', 'Turkish', 'Ukrainian', 'Vietnamese', 'Welsh', 'Sign', 'Algerian', 
  'Aramaic', 'Armenian', 'Berber', 'Burmese', 'Bosnian', 'Brazilian', 
  'Cypriot', 'Corsica', 'Creole', 'Scottish', 'Egyptian', 'Esperanto', 
  'Estonian', 'Finn', 'Flemish', 'Georgian', 'Hawaiian', 'Inuit', 'Irish', 
  'Icelandic', 'Latin', 'Mandarin', 'Nepalese', 'Sanskrit', 'Tagalog', 
  'Tahitian', 'Tibetan', 'Gypsy', 'Wu'
);

CREATE TYPE Gender AS ENUM ('male', 'female');

CREATE TYPE Length AS ENUM ('short', 'medium', 'long', 'very_long', 'humongous');

CREATE TYPE Format AS ENUM ('hardcover', 'ebook', 'audiobook', 'paperback');

-- Tables
CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  au_fname VARCHAR NOT NULL,
  au_lname VARCHAR NOT NULL
);

CREATE TABLE titles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  pages INTEGER,
  price DECIMAL(5, 2),
  pubdate DATE NOT NULL,
  is_available BOOLEAN NOT NULL,
  ISBN CHAR(13) UNIQUE NOT NULL,
  cover_image_url VARCHAR,
  average_rating DECIMAL(3, 2),
  publisher VARCHAR
);

CREATE TABLE titles_authors (
  title_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, author_id),
  CONSTRAINT fk_title FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name Genre NOT NULL
);

CREATE TABLE titles_genres (
  title_id INTEGER NOT NULL,
  genre_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, genre_id),
  CONSTRAINT fk_title_genre FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE
);

CREATE TABLE languages (
  id SERIAL PRIMARY KEY,
  name Language NOT NULL
);

CREATE TABLE titles_languages (
  title_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, language_id),
  CONSTRAINT fk_title_language FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_language FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR UNIQUE NOT NULL,
  fname VARCHAR,
  lname VARCHAR,
  age INTEGER CHECK (age > 0),
  gender Gender,
  location VARCHAR,
  password_hash VARCHAR NOT NULL,
  profile_picture_url VARCHAR
);

CREATE TABLE language_preferences (
  user_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, language_id),
  CONSTRAINT fk_user_language_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_language_pref FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
);

CREATE TABLE genre_preferences (
  user_id INTEGER NOT NULL,
  genre_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, genre_id),
  CONSTRAINT fk_user_genre_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_genre_pref FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE
);

CREATE TABLE author_preferences (
  user_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, author_id),
  CONSTRAINT fk_user_author_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_author_pref FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

CREATE TABLE lengths (
  id SERIAL PRIMARY KEY,
  length Length NOT NULL
);

CREATE TABLE length_preferences (
  user_id INTEGER NOT NULL,
  length_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, length_id),
  CONSTRAINT fk_user_length_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_length FOREIGN KEY (length_id) REFERENCES lengths (id) ON DELETE CASCADE
);

CREATE TABLE formats (
  id SERIAL PRIMARY KEY,
  type Format NOT NULL
);

CREATE TABLE titles_formats (
  title_id INTEGER NOT NULL,
  format_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, format_id),
  CONSTRAINT fk_title_format FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_format FOREIGN KEY (format_id) REFERENCES formats (id) ON DELETE CASCADE
);

CREATE TABLE liked_titles (
  user_id INTEGER NOT NULL,
  title_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, title_id),
  CONSTRAINT fk_user_liked_title FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_liked_title FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE
);

-- Comments
COMMENT ON COLUMN titles.ISBN IS 'Max 13 characters for ISBN.';
