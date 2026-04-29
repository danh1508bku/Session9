-- Tạo index trên category_id (dùng để lọc nhanh theo category)
CREATE INDEX idx_products_category
ON Products(category_id);

-- CLUSTER: sắp xếp vật lý bảng theo index (giả lập clustered index trong PostgreSQL)
-- Sau lệnh này, dữ liệu trong bảng sẽ được lưu theo thứ tự category_id
CLUSTER Products USING idx_products_category;


-- Tạo non-clustered index trên price (hỗ trợ ORDER BY)
CREATE INDEX idx_products_price
ON Products(price);


-- EXPLAIN ANALYZE để xem kế hoạch thực thi và thời gian
EXPLAIN ANALYZE
SELECT *
FROM Products
WHERE category_id = 1
ORDER BY price;


-- Bước 1: WHERE category_id = 1
-- -> PostgreSQL sử dụng idx_products_category
-- -> Tránh phải quét toàn bộ bảng (Seq Scan)
-- -> Chỉ lấy các dòng thuộc category cần tìm

-- Bước 2: ORDER BY price
-- -> PostgreSQL có thể dùng idx_products_price
-- -> Hoặc sẽ sort trên tập dữ liệu đã lọc (ít dòng hơn → nhanh hơn)

-- CLUSTER giúp:
-- -> Các dòng cùng category nằm gần nhau trên đĩa
-- -> Giảm I/O khi đọc dữ liệu
