
create table customers(customer_id int primary key,
customer_name varchar(30),
customer_email varchar(50))

create table products(product_id int primary key,
product_name varchar(30),
product_category varchar(30),
product_price  decimal(10,2))

create table orders(order_id int primary key,
order_date date ,
order_quantity int,
order_total_amount int)

create table relations
(

product_id int,
customer_id int ,
orders_id int 
)
