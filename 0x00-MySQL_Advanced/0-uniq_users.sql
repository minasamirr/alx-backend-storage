-- Creates a table users with id, email, and name attributes
-- Ensures id is an integer, auto-incremented, primary key, and never null
-- Ensures email is a unique string (255 characters) and never null
-- Ensures name is a string (255 characters)
-- If the table already exists, the script will not fail

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
