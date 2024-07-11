-- Creates a table users with id, email, name, and country attributes
-- Ensures id is an integer, auto-incremented, primary key, and never null
-- Ensures email is a unique string (255 characters) and never null
-- Ensures name is a string (255 characters)
-- Ensures country is an enumeration of countries: US, CO, and TN, with a default of US
-- If the table already exists, the script will not fail

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'
);
