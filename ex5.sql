CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,     -- khóa chính, tự tăng
    customer_id INT NOT NULL,       -- mã khách hàng
    amount NUMERIC NOT NULL,        -- số tiền giao dịch
    sale_date DATE NOT NULL         -- ngày bán
);

INSERT INTO Sales (customer_id, amount, sale_date) VALUES
(1, 500, '2024-01-01'),
(2, 700, '2024-01-05'),
(1, 300, '2024-02-01'),
(3, 1000, '2024-03-10');

create or replace procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC)
as $$	
begin
	select coalesce(sum(amount),0) into total from Sales 
	where sale_date between start_date and end_date;
end;
$$ language plpgsql;

CALL calculate_total_sales('2024-01-01', '2024-01-31', NULL);

CALL calculate_total_sales('2025-01-01', '2025-12-31', NULL);
