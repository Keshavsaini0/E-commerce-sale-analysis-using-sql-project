-- drop table if exists customer;
create table customer (customer_id int, name varchar(50), email varchar(50), gender varchar (50) not null, city varchar(50),
				registration_date date);
INSERT INTO customer (customer_id, name, email, gender, city, registration_date)
VALUES
(6, 'Karan Singh', 'karan@example.com', 'Male', 'Hyderabad', '2022-10-10'),
(7, 'Meera Iyer', 'meera@example.com', 'Female', 'Bangalore', '2022-11-12'),
(8, 'Sahil Khan', 'sahil@example.com', 'Male', 'Delhi', '2023-01-01'),
(9, 'Anjali Desai', 'anjali@example.com', 'Female', 'Ahmedabad', '2023-01-05'),
(10, 'Ravi Joshi', 'ravi@example.com', 'Male', 'Kolkata', '2023-01-10');

create table products(product_id int , name varchar, category varchar(50), price int , cost_price int,
					stock_quantity int);

INSERT INTO products (product_id, name, category, price, cost_price, stock_quantity)
VALUES
		(106, 'Bluetooth Speaker', 'Electronics', 1500, 900, 40),
		(107, 'Denim Jeans', 'Apparel', 1800, 1000, 25),
		(108, 'Leather Wallet', 'Accessories', 900, 500, 30),
		(109, 'Ball Pen Set', 'Stationery', 150, 80, 200),
		(110, 'Water Bottle', 'Home & Kitchen', 350, 200, 100),
		(111, 'LED Desk Lamp', 'Home & Kitchen', 1200, 700, 20),
		(112, 'Fitness Band', 'Electronics', 2800, 1900, 10),
		(113, 'Hoodie', 'Apparel', 2200, 1400, 15),
		(114, 'Office Chair', 'Furniture', 7500, 5000, 5),
		(115, 'Sunglasses', 'Accessories', 1100, 700, 18);


create table orders(order_id int , customer_id int , order_date date , payment_mode varchar(50),
					total_amount int);

INSERT INTO orders (order_id, customer_id, order_date, payment_mode, total_amount)
VALUES
		(1006, 5, '2022-11-20', 'Credit Card', 2800),
		(1007, 2, '2022-11-25', 'Net Banking', 1800),
		(1008, 3, '2022-12-01', 'UPI', 1200),
		(1009, 1, '2022-12-10', 'Credit Card', 7500),
		(1010, 4, '2022-12-12', 'Cash on Delivery', 150),
		(1011, 5, '2023-01-05', 'Credit Card', 350),
		(1012, 2, '2023-01-10', 'UPI', 2200),
		(1013, 3, '2023-01-15', 'Credit Card', 1100),
		(1014, 1, '2023-01-20', 'Net Banking', 1200),
		(1015, 4, '2023-01-25', 'UPI', 900);

create table order_details(order_detail_id int , order_id int , product_id int , quantity int , unit_price int,
						discount int);

INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price, discount)
VALUES
	(7, 1006, 112, 1, 2800, 0),
	(8, 1007, 107, 1, 1800, 0),
	(9, 1008, 103, 1, 1200, 0),
	(10, 1009, 114, 1, 7500, 0),
	(11, 1010, 109, 1, 150, 0),
	(12, 1011, 110, 1, 350, 0),
	(13, 1012, 113, 1, 2200, 0),
	(14, 1013, 115, 1, 1100, 0),
	(15, 1014, 108, 1, 1200, 0),
	(16, 1015, 101, 1, 500, 0),
	(17, 1015, 105, 1, 80, 0),
	(18, 1015, 109, 2, 150, 0);

create table returns(return_id int , order_id int , product_id int , return_date date, reason varchar);
INSERT INTO returns (return_id, order_id, product_id, return_date, reason)
VALUES
(3, 1006, 112, '2022-11-23', 'Device Issue'),
(4, 1009, 114, '2022-12-15', 'Damaged on Arrival'),
(5, 1012, 113, '2023-01-12', 'Size Too Small'),
(6, 1015, 109, '2023-01-27', 'Wrong Product Delivered'),
(7, 1007, 107, '2022-11-30', 'Color Mismatch');

select * from customer;
select * from products;
select * from orders;
select * from order_details;
select * from returns;


COPY public.customer(customer_id, name, email, gender, city, registration_date)
FROM 'D:/customer.csv' DELIMITER ',' CSV HEADER;


COPY public.products(product_id, name, category, price, cost_price, stock_quantity)
FROM 'D:/products.csv' DELIMITER ',' CSV HEADER;

COPY public.orders(order_id, customer_id, order_date, payment_mode, total_amount)
FROM 'D:/orders.csv' DELIMITER ',' CSV HEADER;

COPY public.order_details(order_detail_id, order_id, product_id, quantity, unit_price, discount)
FROM 'D:/order_details.csv' DELIMITER ',' CSV HEADER;

COPY public.returns(return_id, order_id, product_id, return_date, reason)
from 'D:/returns.csv' DELIMITER ',' CSV HEADER;



--SQL QUERIES FOR INSIGHTFULL DATA 
select * from customer c
full join 
orders o on c.customer_id = o.customer_id
join 
order_details od on o.order_id = od.order_id
join 
returns r on od.order_id =r.order_id
where gender = 'Male';

--🔍1). Top 5 Returned Products
select p.name as product_name,
	count(r.return_id) as return_count
from returns r 
join products p on r.product_id = p.product_id
group by p.name
order by return_count desc
limit 5;

--🔍2). top 5 Customers with Highest Returns
select c.name as customer_name, 
	count(r.return_id) as total_returns
from returns r 
join orders o on r.order_id = o.order_id
join customer c on o.customer_id = c.customer_id
group by c.name
order by total_returns desc limit 5 ;

--📉 3. Customer Churn Analysis (Inactive for 90+ Days)
Select c.customer_id,
		c.name as customer_name,
		Max(o.order_date) as last_ordered_date,
		Current_date - Max(o.order_date) as days_since_last_order
From customer c
Join orders o on c.customer_id = o.customer_id
Group by c.customer_id,c.name
Having current_date - Max(o.order_date)>90
Order by days_since_last_order Desc;

--📊 4. Top 5 Best Selling Products by Quantity
SELECT p.name as product_name,
	sum(od.quantity) as total_sold
FROM order_details od 
JOIN products p on p.product_id = od.product_id
group by p.name,od.quantity
order by total_sold desc
limit 5;

--💰 5. Profit per Product
select p.name as product_name,
	SUM((od.unit_price - p.cost_price)*od.quantity) as Profit
from order_details od 
join products p on od.product_id = p.product_id
group by p.name
order by profit desc;

--👥 6). Customer Lifetime Value (CLV)
select c.customer_id , c.name as customer_name,
	sum(o.total_amount) as 	Lifetime_value
from orders o 
join customer c On o.customer_id = c.customer_id
Group by c.name,c.customer_id
order by lifetime_value desc ;

--🏙️ 7). Sales by City
select  c.city, sum(o.total_amount) as total_sales
from customer c
join orders o on c.customer_id =o.customer_id
GROUP by c.city
order by total_sales desc;

--📅 8). Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) AS monthly_revenue
FROM orders o
GROUP BY month
ORDER BY month;

