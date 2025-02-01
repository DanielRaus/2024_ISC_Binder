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

-- First primary table, containing essential information about the books
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

-- Table linking books to their authors
CREATE TABLE titles_authors (
  title_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, author_id),
  CONSTRAINT fk_title FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

-- Table containing all possible genres
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name Genre NOT NULL
);

-- Table linking books to one or more genres
CREATE TABLE titles_genres (
  title_id INTEGER NOT NULL,
  genre_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, genre_id),
  CONSTRAINT fk_title_genre FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE
);

-- Table containing all available languages
CREATE TABLE languages (
  id SERIAL PRIMARY KEY,
  name Language NOT NULL
);

-- Table linking books to their languages
CREATE TABLE titles_languages (
  title_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, language_id),
  CONSTRAINT fk_title_language FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_language FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
);

-- Second primary table, containing all essential informations about the users
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

-- Table linking individual users to their selected language preferences
CREATE TABLE language_preferences (
  user_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, language_id),
  CONSTRAINT fk_user_language_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_language_pref FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
);

-- Table linking users to their selected genre preferences
CREATE TABLE genre_preferences (
  user_id INTEGER NOT NULL,
  genre_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, genre_id),
  CONSTRAINT fk_user_genre_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_genre_pref FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE
);

-- Table linking users to their favorite authors
CREATE TABLE author_preferences (
  user_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, author_id),
  CONSTRAINT fk_user_author_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_author_pref FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

-- Table containing all possible book lengths
CREATE TABLE lengths (
  id SERIAL PRIMARY KEY,
  length Length NOT NULL
);

-- Table linking users to their preffered lengths
CREATE TABLE length_preferences (
  user_id INTEGER NOT NULL,
  length_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, length_id),
  CONSTRAINT fk_user_length_pref FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_length FOREIGN KEY (length_id) REFERENCES lengths (id) ON DELETE CASCADE
);

-- Table containing all possible formats
CREATE TABLE formats (
  id SERIAL PRIMARY KEY,
  type Format NOT NULL
);

-- Table linking books to their formats
CREATE TABLE titles_formats (
  title_id INTEGER NOT NULL,
  format_id INTEGER NOT NULL,
  PRIMARY KEY (title_id, format_id),
  CONSTRAINT fk_title_format FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE,
  CONSTRAINT fk_format FOREIGN KEY (format_id) REFERENCES formats (id) ON DELETE CASCADE
);

-- Table matching users to their liked books
CREATE TABLE liked_titles (
  user_id INTEGER NOT NULL,
  title_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, title_id),
  CONSTRAINT fk_user_liked_title FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_liked_title FOREIGN KEY (title_id) REFERENCES titles (id) ON DELETE CASCADE
);

-- Indexes for faster querying
CREATE INDEX idx_titles_authors_title_id ON titles_authors (title_id);
CREATE INDEX idx_titles_authors_author_id ON titles_authors (author_id);

CREATE INDEX idx_titles_genres_title_id ON titles_genres (title_id);
CREATE INDEX idx_titles_genres_genre_id ON titles_genres (genre_id);

CREATE INDEX idx_titles_languages_title_id ON titles_languages (title_id);
CREATE INDEX idx_titles_languages_language_id ON titles_languages (language_id);

CREATE INDEX idx_language_preferences_user_id ON language_preferences (user_id);
CREATE INDEX idx_language_preferences_language_id ON language_preferences (language_id);

CREATE INDEX idx_genre_preferences_user_id ON genre_preferences (user_id);
CREATE INDEX idx_genre_preferences_genre_id ON genre_preferences (genre_id);

CREATE INDEX idx_author_preferences_user_id ON author_preferences (user_id);
CREATE INDEX idx_author_preferences_author_id ON author_preferences (author_id);

CREATE INDEX idx_length_preferences_user_id ON length_preferences (user_id);
CREATE INDEX idx_length_preferences_length_id ON length_preferences (length_id);

CREATE INDEX idx_titles_formats_title_id ON titles_formats (title_id);
CREATE INDEX idx_titles_formats_format_id ON titles_formats (format_id);

CREATE INDEX idx_liked_titles_user_id ON liked_titles (user_id);
CREATE INDEX idx_liked_titles_title_id ON liked_titles (title_id);

CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_location ON users (location);

CREATE INDEX idx_titles_ISBN ON titles (ISBN);
CREATE INDEX idx_titles_publisher ON titles (publisher);
CREATE INDEX idx_titles_is_available ON titles (is_available);
CREATE INDEX idx_titles_average_rating ON titles (average_rating);
CREATE INDEX idx_titles_pubdate ON titles (pubdate);

CREATE INDEX idx_genres_name ON genres (name);
CREATE INDEX idx_languages_name ON languages (name);
