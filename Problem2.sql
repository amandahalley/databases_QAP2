-- CREATING TABLES

--Create products table
CREATE TABLE products (
products_id SERIAL PRIMARY KEY,
product_name TEXT,
price DECIMAL(10,2),
stock_quantity INT
)

-- Create customers table
CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT UNIQUE
)

-- Create orders table
CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
order_date DATE
)

-- Create order-items table 
CREATE TABLE order_items (
order_id INT,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	
product_id INT,
	FOREIGN KEY (product_id) REFERENCES products(products_id),
	
quantity INT, 
PRIMARY KEY (order_id, product_id)
)

-- INSERT DATA INTO TABLES

-- Insert products into products table
INSERT INTO products (product_name, price, stock_quantity) VALUES 
('Hoodie', '60.00', '30'),
('Jeans', '90.00', '20'),
('Sweatpants', '70.00', '30'),
('T-shirt', '20.00', '50'),
('Long-sleeve', '30.00', '50')

-- Insert customer information into customers table
INSERT INTO customers (first_name, last_name, email) VALUES 
('Amanda', 'Halley', 'amanda.halley@example.com'),
('Jane', 'Doe', 'jane.doe@example.com'),
('John', 'Smith', 'john.smith@example.com'),
('Sally', 'Thorne', 'sally.thorne@example.com')

-- Insert orders into orders table
INSERT INTO orders (customer_id, order_date) VALUES 
('1', '2024-01-02'),
('2', '2024-05-12'),
('3', '2024-06-24'),
('4', '2024-09-30'),
('3', '2024-10-12')

-- Each order should have at least 2 items ordered
INSERT INTO order_items (order_id, product_id, quantity) VALUES 
('1', '1', '5'),
('1', '3', '2'),
('2', '4', '2'),
('2', '5', '2'),
('3', '1', '2'),
('3', '2', '5'),
('4', '3', '4'),
('4', '4', '5'),
('5', '1', '2'),
('5', '4', '8')


-- TASKS

-- Retrieve the names and stock quantities of all products.
SELECT product_name, stock_quantity
FROM products

-- Retrieve the product names and quantities for one of the orders placed.
SELECT products.product_name, order_items.quantity 
FROM order_items
JOIN products ON order_items.product_id = products_id
WHERE order_items.order_id = 1   

-- Retrieve all orders placed by a specific customer (including the ID’s of what was ordered and the quantities).
SELECT orders.customer_id AS order_id, order_items.product_id, order_items.quantity
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.products_id
WHERE orders.customer_id = 3

-- Update quantity of items in stock after a customer places an order 
-- in this case, t-shirt and longsleve quantity was updated and both reduced by 2
UPDATE products
SET stock_quantity = stock_quantity - order_items.quantity
FROM order_items
WHERE products.products_id = order_items.product_id
AND orders.customer_id = 2;

-- Remove one of the orders and all associated order items from the system.
-- Removing order 1
DELETE FROM order_items
WHERE order_id = 1;
DELETE FROM orders
WHERE order_id = 1 ;




