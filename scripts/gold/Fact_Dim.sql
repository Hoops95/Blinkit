
---------------Fact_order_items----

CREATE OR REPLACE VIEW gold.fact_order_items AS
SELECT
    -- Foreign Keys
    p.product_key,
    
    oi.order_id,
    oi.product_id,

    -- Metrics
    oi.quantity,
    oi.unit_price,
    oi.total_price

   
  

FROM silver.order_items oi

-- Product Dimension
LEFT JOIN gold.dim_products p
    ON p.product_id = oi.product_id

----------------------------------------------------------------------------------------
---------------------------dim_products--------------------------------------------------------------

create or replace view gold.dim_products as 
select row_number() over(order by product_id) as product_key,
product_id,
product_name,
category,
brand,
price,
mrp,
margin_percentage,
shelf_life_days,
min_stock_level,
max_stock_level
from silver.products


-------------------------------------------------
-----------------------Aggregated_Data----------

CREATE OR REPLACE VIEW silver.order_items_agg AS
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    SUM(total_price) AS total_value,
    COUNT(*) AS items_count
FROM silver.order_items
GROUP BY order_id;
--------------------------------
CREATE OR REPLACE VIEW silver.delivery_agg AS
SELECT DISTINCT ON (order_id)
    order_id,
    delivery_time_minutes,
    distance_km,
    reasons_if_delayed
FROM silver.delivery
ORDER BY order_id;
------------------------------------------------------------
CREATE OR REPLACE VIEW silver.customer_feedback_agg AS
SELECT DISTINCT ON (order_id)
    order_id,
    feedback_id,
    feedback_date
FROM silver.customer_feedback
ORDER BY order_id, feedback_date DESC;
-------------------------------------------------------------
ALTER TABLE gold.dim_feedback
ADD COLUMN feedback_date_key INT;


----------------------------------------------------
CREATE OR REPLACE VIEW gold.dim_feedback1 AS
select row_number() over(order by f.feedback_id) as feedback_key,
f.feedback_id,
f.rating,
f.customer_id,
f.feedback_text,
f.feedback_category,
f.sentiment,
d.date_key AS feedback_date_key
FROM silver.customer_feedback f
LEFT JOIN gold.dim_date d
    ON d.full_date = DATE(f.feedback_date);

-------------------------------------------------FactSales______________________________________
CREATE VIEW gold.fact_sales AS
SELECT
    o.order_id,

    -- Customer Dimension
    c.customer_key,

    -- Dates
    d1.date_key AS order_date_key,
    d2.date_key AS promised_date_key,
    d3.date_key AS actual_date_key,

    fd.feedback_key,
    fd.feedback_date_key,

    -- Order Attributes
    o.order_total,
    o.payment_method,
    o.delivery_partner_id,
    o.delivery_status,

    -- Items Aggregated
    oi.total_quantity,
    oi.total_value,
    oi.items_count,

    -- Delivery Aggregated
    dp.delivery_time_minutes,
    dp.distance_km,
    dp.reasons_if_delayed

FROM silver.orders o

LEFT JOIN gold.dim_customers c
    ON c.customer_id = o.customer_id

LEFT JOIN silver.order_items_agg oi
    ON oi.order_id = o.order_id

LEFT JOIN silver.delivery_agg dp
    ON dp.order_id = o.order_id


LEFT JOIN silver.customer_feedback_agg fagg
    ON fagg.order_id = o.order_id

LEFT JOIN gold.dim_feedback fd
    ON fd.feedback_id = fagg.feedback_id

LEFT JOIN gold.dim_date d1
    ON d1.full_date = DATE(o.order_date)

LEFT JOIN gold.dim_date d2
    ON d2.full_date = DATE(o.promised_delivery_time)

LEFT JOIN gold.dim_date d3
    ON d3.full_date = DATE(o.actual_delivery_time);
select count(*) from silver.inventory;

CREATE OR REPLACE VIEW gold.fact_sales_final AS
SELECT
    f.*,
    p.product_key
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_id = f.product_id;