-- Insert into Products
INSERT INTO Products (sku_number, product_name, description, price, quantity)
VALUES ('SKU001', 'Product 1', 'Description 1', 19.99, 100),
       ('SKU002', 'Product 2', 'Description 2', 29.99, 200),
       ('SKU003', 'Product 3', 'Description 3', 39.99, 150),
       ('SKU004', 'Product 4', 'Description 4', 49.99, 300);

-- Insert into Categories
INSERT INTO Categories (category_name)
VALUES ('Category1'),
       ('Category2'),
       ('Category3');

-- Insert into Variants
INSERT INTO Variants (variant_name)
VALUES ('Size'),
       ('Color'),
       ('Style');

-- Insert into Customers
INSERT INTO Customers (first_name, last_name, email)
VALUES ('John', 'Doe', 'john.doe@example.com'),
       ('Jane', 'Smith', 'jane.smith@example.com'),
       ('Michael', 'Johnson', 'michael.johnson@example.com');

