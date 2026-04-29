
CREATE OR REPLACE VIEW CustomerSales AS
SELECT 
    customer_id,
    SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;


-- Lấy các khách có tổng chi tiêu > 1000
SELECT *
FROM CustomerSales
WHERE total_amount > 1000;



-- Thử update trực tiếp trên view
UPDATE CustomerSales
SET total_amount = 5000
WHERE customer_id = 1;

-- View CustomerSales là view có GROUP BY (aggregate view)
-- => PostgreSQL KHÔNG cho phép UPDATE trực tiếp

-- Lý do:
-- - total_amount là giá trị tính toán (SUM)
-- - Không ánh xạ trực tiếp tới 1 dòng cụ thể trong bảng Sales


-- Sau đó query lại view để thấy thay đổi
SELECT *
FROM CustomerSales;
