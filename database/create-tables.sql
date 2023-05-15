-- Create the Products table
CREATE TABLE IF NOT EXISTS Products (
    product_id SERIAL PRIMARY KEY,
    sku_number VARCHAR(50) UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Categories table
CREATE TABLE IF NOT EXISTS Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Products_Categories table to establish a many-to-many relationship between Products and Categories
CREATE TABLE IF NOT EXISTS Products_Categories (
    product_id INT REFERENCES Products(product_id),
    category_id INT REFERENCES Categories(category_id),
    PRIMARY KEY (product_id, category_id)
);

-- Create the Variants table
CREATE TABLE IF NOT EXISTS Variants (
    variant_id SERIAL PRIMARY KEY,
    variant_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Products_Variants table to establish a many-to-many relationship between Products and Variants
CREATE TABLE IF NOT EXISTS Products_Variants (
    product_id INT REFERENCES Products(product_id),
    variant_id INT REFERENCES Variants(variant_id),
    PRIMARY KEY (product_id, variant_id)
);

-- Create the Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_amount NUMERIC(10, 2) NOT NULL,
    shipping_amount NUMERIC(10, 2) NOT NULL,
    tax_amount NUMERIC(10, 2) NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Order_Items table to establish a many-to-many relationship between Orders and Products
CREATE TABLE IF NOT EXISTS Order_Items (
    order_id INT REFERENCES Orders(order_id),
    product_id INT REFERENCES Products(product_id),
    quantity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- Create the Shipments table
CREATE TABLE IF NOT EXISTS Shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    tracking_number VARCHAR(50) UNIQUE,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Alter the tables to set the auto-increment starting from 100
-- Set auto-increment starting value for Products table
ALTER SEQUENCE Products_product_id_seq RESTART WITH 100;

-- Set auto-increment starting value for Categories table
ALTER SEQUENCE Categories_category_id_seq RESTART WITH 100;

-- Set auto-increment starting value for Variants table
ALTER SEQUENCE Variants_variant_id_seq RESTART WITH 100;

-- Set auto-increment starting value for Customers table
ALTER SEQUENCE Customers_customer_id_seq RESTART WITH 100;

-- Set auto-increment starting value for Orders table
ALTER SEQUENCE Orders_order_id_seq RESTART WITH 100;

-- Set auto-increment starting value for Shipments table
ALTER SEQUENCE Shipments_shipment_id_seq RESTART WITH 100;
