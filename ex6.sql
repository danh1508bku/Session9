CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,   -- khóa chính, tự tăng
    name VARCHAR(100) NOT NULL,      -- tên sản phẩm
    price NUMERIC NOT NULL,          -- giá sản phẩm
    category_id INT NOT NULL         -- mã danh mục
);

INSERT INTO Products (name, price, category_id) VALUES
('Áo', 100000, 1),
('Quần', 200000, 1),
('Giày', 300000, 2);

create or replace procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC)
as $$
declare 
	v_rec record;
	v_new_price numeric;
begin
	for v_rec in select * from Products
	where category_id = p_category_id
	loop
		v_new_price := v_rec.price + (v_rec.price*p_increase_percent/100);
		update Products
		set price = v_new_price
		where product_id = v_rec.product_id;
	end loop;
end;
$$ language plpgsql;

CALL update_product_price(1, 10);

SELECT * FROM Products;
