-- 1. Truy vấn trước khi tạo Index
EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 1;


-- 2. Tạo B-Tree Index trên customer_id
CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);


-- 3. Truy vấn sau khi tạo Index
EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 1;
