CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,     
    name VARCHAR(100) NOT NULL,         
    total_spent NUMERIC DEFAULT 0       
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,        
    customer_id INT NOT NULL references Customers(customer_id),           
    total_amount NUMERIC NOT NULL      
);

create or replace procedure add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC)
as $$
declare 
	v_customer_id INT;
begin
	select customer_id into v_customer_id from Customers 
	where customer_id = p_customer_id;

	if v_customer_id is null then raise exception 'Khách hàng không tồn tại';
	end if;

	insert into Orders(customer_id, total_amount)
	values (v_customer_id, p_amount);

	update Customers
	set total_spent = total_spent + p_amount
	where customer_id = v_customer_id;
exception 
	when others then raise exception 'Thêm đơn hàng thất bại: %', SQLERRM; 
end;
$$ language plpgsql;

INSERT INTO Customers (name, total_spent) VALUES
('An', 0),
('Bình', 1000);


CALL add_order_and_update_customer(1, 500);

SELECT * FROM Orders;
SELECT * FROM Customers;

CALL add_order_and_update_customer(99, 500);
