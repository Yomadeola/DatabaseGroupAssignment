CREATE DATABASE bookstore;
USE bookstore;
-- 4. Book_Language table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL
);

-- 5. Publisher table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address TEXT
);

-- 1. Book table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    publication_year INT,
    isbn VARCHAR(20),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 3. Author table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    bio TEXT
);

-- 2. Book_Author join table (many-to-many relationship)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

show tables;

-- Insert languages
INSERT INTO book_language (language_name) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Chinese'),
('Japanese'),
('Russian'),
('Italian');

-- Insert publishers
INSERT INTO publisher (name, address) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019, USA'),
('HarperCollins', '195 Broadway, New York, NY 10007, USA'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA'),
('Macmillan Publishers', '120 Broadway, New York, NY 10271, USA'),
('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104, USA');

-- Insert authors
INSERT INTO author (name, bio) VALUES
('J.K. Rowling', 'British author best known for the Harry Potter series'),
('Stephen King', 'American author of horror, supernatural fiction, suspense, and fantasy novels'),
('Agatha Christie', 'English writer known for her detective novels'),
('Haruki Murakami', 'Japanese writer whose books and stories have been bestsellers in Japan and internationally'),
('Gabriel García Márquez', 'Colombian novelist known for magical realism'),
('Jane Austen', 'English novelist known for her six major novels'),
('Ernest Hemingway', 'American novelist, short-story writer, and journalist'),
('Virginia Woolf', 'English writer and modernist'),
('Toni Morrison', 'American novelist, essayist, and professor'),
('George Orwell', 'English novelist, essayist, journalist, and critic');

-- Insert books
INSERT INTO book (title, publisher_id, language_id, publication_year, isbn) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 1, 1997, '9780747532743'),
('The Shining', 2, 1, 1977, '9780385121675'),
('Murder on the Orient Express', 3, 1, 1934, '9780007119318'),
('Norwegian Wood', 4, 6, 1987, '9780375704024'),
('One Hundred Years of Solitude', 5, 2, 1967, '9780060883287'),
('Pride and Prejudice', 1, 1, 1813, '9780141439518'),
('The Old Man and the Sea', 2, 1, 1952, '9780684801223'),
('To the Lighthouse', 3, 1, 1927, '9780156907392'),
('Beloved', 4, 1, 1987, '9781400033416'),
('1984', 5, 1, 1949, '9780451524935'),
('It', 1, 1, 1986, '9780450411434'),
('Death on the Nile', 2, 1, 1937, '9780062073556'),
('Kafka on the Shore', 3, 6, 2002, '9781400079278'),
('Love in the Time of Cholera', 4, 2, 1985, '9780307389732'),
('Sense and Sensibility', 5, 1, 1811, '9780141439662');

-- Insert book_author relationships
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),  -- Harry Potter - J.K. Rowling
(2, 2),  -- The Shining - Stephen King
(3, 3),  -- Murder on the Orient Express - Agatha Christie
(4, 4),  -- Norwegian Wood - Haruki Murakami
(5, 5),  -- One Hundred Years of Solitude - Gabriel García Márquez
(6, 6),  -- Pride and Prejudice - Jane Austen
(7, 7),  -- The Old Man and the Sea - Ernest Hemingway
(8, 8),  -- To the Lighthouse - Virginia Woolf
(9, 9),  -- Beloved - Toni Morrison
(10, 10), -- 1984 - George Orwell
(11, 2),  -- It - Stephen King
(12, 3),  -- Death on the Nile - Agatha Christie
(13, 4),  -- Kafka on the Shore - Haruki Murakami
(14, 5),  -- Love in the Time of Cholera - Gabriel García Márquez
(15, 6);  -- Sense and Sensibility - Jane Austen

-- 6. Country table
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL
);

-- 7. Address table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_number VARCHAR(20),
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 8. Address_Status table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

-- 9. Customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 10. Customer_Address table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 11. Order_Status table
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

-- 12. Shipping_Method table
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- 13. Cust_Order table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT NOT NULL,
    address_id INT NOT NULL,
    order_status_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(status_id)
);

-- 14. Order_Line table
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. Order_History table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Insert data into Country table
INSERT INTO country (country_name) VALUES
('United States'),
('United Kingdom'),
('Canada'),
('Australia'),
('Germany'),
('France'),
('Japan'),
('India'),
('Kenya'),
('South Africa');

-- Insert data into Address_Status table
INSERT INTO address_status (status_name) VALUES
('Current'),
('Previous'),
('Billing'),
('Shipping'),
('Temporary'),
('Business'),
('Home');

-- Insert data into Address table
INSERT INTO address (street_number, street_name, city, state_province, postal_code, country_id) VALUES
('123', 'Main Street', 'New York', 'NY', '10001', 1),
('456', 'Oxford Street', 'London', 'England', 'W1D 1BS', 2),
('789', 'Maple Avenue', 'Toronto', 'Ontario', 'M5V 2H1', 3),
('101', 'Sunshine Boulevard', 'Sydney', 'NSW', '2000', 4),
('202', 'Berliner Straße', 'Berlin', 'Berlin', '10115', 5),
('303', 'Rue de Rivoli', 'Paris', 'Île-de-France', '75001', 6),
('404', 'Sakura Avenue', 'Tokyo', 'Tokyo', '100-0001', 7),
('505', 'Gandhi Road', 'Mumbai', 'Maharashtra', '400001', 8),
('606', 'Kenyatta Avenue', 'Nairobi', 'Nairobi', '00100', 9),
('707', 'Nelson Mandela Boulevard', 'Cape Town', 'Western Cape', '8001', 10),
('888', 'Technology Park', 'San Francisco', 'CA', '94105', 1),
('999', 'Queen Street', 'Toronto', 'Ontario', 'M5H 2M9', 3);

-- Insert data into Customer table
INSERT INTO customer (first_name, last_name, email, phone, registration_date) VALUES
('John', 'Smith', 'john.smith@email.com', '555-123-4567', '2023-01-15 10:30:00'),
('Emma', 'Johnson', 'emma.johnson@email.com', '555-234-5678', '2023-02-20 14:45:00'),
('Michael', 'Williams', 'michael.williams@email.com', '555-345-6789', '2023-03-05 09:15:00'),
('Sophia', 'Brown', 'sophia.brown@email.com', '555-456-7890', '2023-03-18 16:20:00'),
('William', 'Jones', 'william.jones@email.com', '555-567-8901', '2023-04-02 11:10:00'),
('Olivia', 'Garcia', 'olivia.garcia@email.com', '555-678-9012', '2023-04-25 13:30:00'),
('James', 'Miller', 'james.miller@email.com', '555-789-0123', '2023-05-12 15:40:00'),
('Ava', 'Davis', 'ava.davis@email.com', '555-890-1234', '2023-05-30 10:05:00'),
('Alexander', 'Rodriguez', 'alexander.rodriguez@email.com', '555-901-2345', '2023-06-15 12:20:00'),
('Isabella', 'Wilson', 'isabella.wilson@email.com', '555-012-3456', '2023-06-28 17:15:00'),
('Benjamin', 'Taylor', 'benjamin.taylor@email.com', '555-123-7890', '2023-07-10 09:45:00'),
('Mia', 'Thomas', 'mia.thomas@email.com', '555-234-8901', '2023-07-25 14:30:00');

-- Insert data into Customer_Address table
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), -- John Smith's current address
(2, 2, 1), -- Emma Johnson's current address
(3, 3, 1), -- Michael Williams' current address
(4, 4, 1), -- Sophia Brown's current address
(5, 5, 1), -- William Jones' current address
(6, 6, 1), -- Olivia Garcia's current address
(7, 7, 1), -- James Miller's current address
(8, 8, 1), -- Ava Davis's current address
(9, 9, 1), -- Alexander Rodriguez's current address
(10, 10, 1), -- Isabella Wilson's current address
(11, 11, 1), -- Benjamin Taylor's current address
(11, 12, 3), -- Benjamin Taylor's billing address
(12, 12, 1); -- Mia Thomas's current address

-- Insert data into Order_Status table
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned'),
('On Hold');

-- Insert data into Shipping_Method table
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 5.99),
('Express Shipping', 12.99),
('Overnight Shipping', 24.99),
('In-Store Pickup', 0.00),
('International Economy', 15.99),
('International Priority', 29.99);

-- The following inserts assume that book_language, publisher, book, and author tables
-- have already been populated with data

-- Let's assume we have these book IDs available for the order lines
-- book_id 1: "The Great Gatsby"
-- book_id 2: "To Kill a Mockingbird"
-- book_id 3: "1984"
-- book_id 4: "Pride and Prejudice"
-- book_id 5: "The Hobbit"

-- Insert data into Cust_Order table
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, address_id, order_status_id, total_amount) VALUES
(1, '2023-08-10 09:25:00', 1, 1, 4, 35.97), -- John Smith, delivered
(2, '2023-08-15 14:30:00', 2, 2, 3, 42.98), -- Emma Johnson, shipped
(3, '2023-08-20 11:15:00', 1, 3, 2, 25.98), -- Michael Williams, processing
(4, '2023-08-25 16:45:00', 3, 4, 3, 74.97), -- Sophia Brown, shipped
(5, '2023-09-01 10:20:00', 1, 5, 1, 19.99), -- William Jones, pending
(6, '2023-09-05 13:10:00', 4, 6, 4, 29.98), -- Olivia Garcia, delivered
(7, '2023-09-10 15:30:00', 1, 7, 5, 45.97), -- James Miller, cancelled
(8, '2023-09-15 12:40:00', 2, 8, 3, 38.99), -- Ava Davis, shipped
(9, '2023-09-20 09:15:00', 5, 9, 2, 62.98), -- Alexander Rodriguez, processing
(10, '2023-09-25 14:50:00', 1, 10, 4, 24.99); -- Isabella Wilson, delivered

-- Insert data into Order_Line table
INSERT INTO order_line (order_id, book_id, quantity, price_per_unit) VALUES
(1, 1, 1, 15.99), -- John Smith ordered The Great Gatsby
(1, 2, 1, 19.98), -- John Smith ordered To Kill a Mockingbird
(2, 3, 2, 21.49), -- Emma Johnson ordered two copies of 1984
(3, 4, 1, 12.99), -- Michael Williams ordered Pride and Prejudice
(3, 5, 1, 12.99), -- Michael Williams ordered The Hobbit
(4, 1, 1, 15.99), -- Sophia Brown ordered The Great Gatsby
(4, 2, 1, 19.99), -- Sophia Brown ordered To Kill a Mockingbird
(4, 3, 1, 38.99), -- Sophia Brown ordered 1984
(5, 4, 1, 19.99), -- William Jones ordered Pride and Prejudice
(6, 5, 2, 14.99), -- Olivia Garcia ordered two copies of The Hobbit
(7, 1, 1, 15.99), -- James Miller ordered The Great Gatsby
(7, 3, 1, 21.99), -- James Miller ordered 1984
(7, 5, 1, 7.99), -- James Miller ordered The Hobbit
(8, 2, 1, 19.99), -- Ava Davis ordered To Kill a Mockingbird
(8, 4, 1, 19.00), -- Ava Davis ordered Pride and Prejudice
(9, 1, 2, 15.99), -- Alexander Rodriguez ordered two copies of The Great Gatsby
(9, 5, 2, 15.50), -- Alexander Rodriguez ordered two copies of The Hobbit
(10, 3, 1, 24.99); -- Isabella Wilson ordered 1984

-- Insert data into Order_History table
INSERT INTO order_history (order_id, status_id, status_date, notes) VALUES
(1, 1, '2023-08-10 09:25:00', 'Order placed'),
(1, 2, '2023-08-10 10:30:00', 'Payment confirmed'),
(1, 3, '2023-08-11 14:15:00', 'Order shipped'),
(1, 4, '2023-08-13 11:20:00', 'Order delivered'),
(2, 1, '2023-08-15 14:30:00', 'Order placed'),
(2, 2, '2023-08-15 15:45:00', 'Payment confirmed'),
(2, 3, '2023-08-16 09:30:00', 'Order shipped'),
(3, 1, '2023-08-20 11:15:00', 'Order placed'),
(3, 2, '2023-08-20 13:25:00', 'Payment confirmed'),
(4, 1, '2023-08-25 16:45:00', 'Order placed'),
(4, 2, '2023-08-25 17:30:00', 'Payment confirmed'),
(4, 3, '2023-08-26 09:15:00', 'Order shipped'),
(5, 1, '2023-09-01 10:20:00', 'Order placed'),
(6, 1, '2023-09-05 13:10:00', 'Order placed'),
(6, 2, '2023-09-05 14:25:00', 'Payment confirmed'),
(6, 3, '2023-09-06 10:30:00', 'Ready for pickup'),
(6, 4, '2023-09-07 16:15:00', 'Order picked up'),
(7, 1, '2023-09-10 15:30:00', 'Order placed'),
(7, 2, '2023-09-10 16:40:00', 'Payment confirmed'),
(7, 5, '2023-09-11 09:45:00', 'Cancelled by customer'),
(8, 1, '2023-09-15 12:40:00', 'Order placed'),
(8, 2, '2023-09-15 13:55:00', 'Payment confirmed'),
(8, 3, '2023-09-16 11:20:00', 'Order shipped'),
(9, 1, '2023-09-20 09:15:00', 'Order placed'),
(9, 2, '2023-09-20 10:30:00', 'Payment confirmed'),
(10, 1, '2023-09-25 14:50:00', 'Order placed'),
(10, 2, '2023-09-25 15:30:00', 'Payment confirmed'),
(10, 3, '2023-09-26 10:45:00', 'Order shipped'),
(10, 4, '2023-09-28 13:20:00', 'Order delivered');

