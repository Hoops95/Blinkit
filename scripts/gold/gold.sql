
create table silver.customers as 
select customer_id,
customer_name,
email,
phone,
address,
area,
pincode,
customer_segment,
cast(registration_date as date) as registration_date,
total_orders,
avg_order_value 
from bronze.blinkit_customers;
--------------------------DIM_Customers--------------------------------
Drop view if exists gold.dim_products;

create view gold.dim_customers as 
select row_number() over (order by customer_id) as Customer_key,
customer_id,
customer_name,
email,
phone,
address,
area,
pincode,
registration_date,
total_orders,
customer_segment,
avg_order_value
from silver.customers;
------------------------------------------------------------------------

create view gold.dim_products as 
select row_number() over(order by p.product_id) as product_key,
p.product_id,
p.product_name,
p.category,
p.brand,
p.price,
p.mrp,
p.margin_percentage,
p.shelf_life_days,
p.min_stock_level,
p.max_stock_level,
i.stock_received,
i.damaged_stock
from silver.products p left join silver.inventory i
on p.product_id = i.product_id;
------------------------------------------------------------------------
create view gold.dim_orders as 
select row_number() over(order by order_id) as order_key,
order_id,
delivery_partner_id,
delivery_status,
payment_method
from silver.orders
--------------------------------------------------------------------------
create view gold.dim_feedback as 
select row_number() over(order by feedback_id) as feedback_key,
feedback_id,
rating,
feedback_text,
feedback_category,
sentiment
from silver.customer_feedback
--------------------------------Fact----------------------------------------
