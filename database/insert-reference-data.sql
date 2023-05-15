-- Insert into Products_Categories
INSERT INTO Products_Categories (product_id, category_id)
VALUES (100, 100),
       (100, 101),
       (101, 100),
       (102, 102),
       (103, 101),
       (103, 102);

-- Insert into Products_Variants
INSERT INTO Products_Variants (product_id, variant_id)
VALUES (100, 100),
       (100, 101),
       (101, 100),
       (102, 101),
       (102, 102),
       (103, 101),
       (103, 102);

-- Insert into Orders
INSERT INTO Orders (customer_id, order_amount, shipping_amount, tax_amount, total)
VALUES (100, 150.00, 10.00, 15.00, 175.00),
       (101, 200.00, 15.00, 20.00, 235.00),
       (102, 100.00, 8.00, 10.00, 118.00);

-- Insert into Order_Items
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES (100, 100, 2, 19.99),
       (100, 101, 1, 29.99),
       (101, 102, 3, 49.99),
       (102, 100, 1, 19.99),
       (102, 103, 2, 39.99);

-- Insert into Shipments with random tracking numbers
INSERT INTO Shipments (order_id, tracking_number, status)
SELECT order_id, substr(md5(random()::text), 1, 10), 'Shipped'
FROM Orders;