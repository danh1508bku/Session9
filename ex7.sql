CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC,
    order_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO Customers (name, email) VALUES
('An', 'an@gmail.com'),
('Bình', 'binh@gmail.com');

create or replace procedure add_order(p_customer_id INT, p_amount NUMERIC) 
as $$
declare 
	v_customer_id int;
begin
	select customer_id into v_customer_id from Customers
	where customer_id = p_customer_id;

	if v_customer_id is null then raise exception 'Khách hàng không tồn tại';
	end if;

	insert into Orders(customer_id, amount)
	values (p_customer_id, p_amount);
end;
$$ language plpgsql;

CALL add_order(1, 500);
CALL add_order(99, 1000);

SELECT * FROM Orders;
