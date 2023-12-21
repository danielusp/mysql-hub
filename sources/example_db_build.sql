SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `books`
-- 

CREATE DATABASE IF NOT EXISTS books;
USE books;

CREATE TABLE PublishingCompany (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);

CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publishing_company_id INT,
    FOREIGN KEY (publishing_company_id) REFERENCES PublishingCompany(company_id)
);

INSERT INTO PublishingCompany (company_name) VALUES ('Penguin Random House');
INSERT INTO PublishingCompany (company_name) VALUES ('HarperCollins Publishers');
INSERT INTO PublishingCompany (company_name) VALUES ('Simon & Schuster');

INSERT INTO Book (title, author, publishing_company_id) VALUES ('1984', 'George Orwell', 1);
INSERT INTO Book (title, author, publishing_company_id) VALUES ('To Kill a Mockingbird', 'Harper Lee', 2);
INSERT INTO Book (title, author, publishing_company_id) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', 3);

-- 
-- Privileges to user mytest
-- 
GRANT ALL PRIVILEGES ON *.* TO 'mytest'@'%';