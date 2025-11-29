---=========================================================
--⭐ 1) --Feedback
--=========================================================

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.customer_feedback';
END;
$$;
INSERT INTO silver.customer_feedback
SELECT
   feedback_id,
   order_id,
   customer_id,
   CAST(rating AS smallint),
   REPLACE(REPLACE(TRIM(feedback_text), E'\n', ' '), E'\r', ' '),
   feedback_category,
   sentiment,
   CAST(feedback_date AS timestamp)
FROM bronze.blinkit_customer_feedback;
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.customer_feedback';
END;
$$;
---=========================================================
--⭐ 2) --customers
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.customers';
END;
$$;

INSERT INTO silver.customers
SELECT
    customer_id,
    customer_name,
    email,
    phone,
    address,
    area,
    pincode,
    CAST(registration_date AS date),
    total_orders,
    avg_order_value
FROM bronze.blinkit_customers;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.customers';
END;
$$;
---=========================================================
--⭐ 3) --delivery
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.delivery';
END;
$$;

INSERT INTO silver.delivery
SELECT 
    order_id,
    delivery_partner_id,
    CAST(promised_time AS timestamp),
    CAST(actual_time AS timestamp),
    delivery_time_minutes,
    distance_km,
    delivery_status,
    reasons_if_delayed,
    CASE WHEN delivery_time_minutes > 0 THEN TRUE ELSE FALSE END
FROM bronze.blinkit_delivery_performance;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.delivery';
END;
$$;
---=========================================================
--⭐ 4) --inventory
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.inventory';
END;
$$;

INSERT INTO silver.inventory
SELECT
    product_id,
    TO_DATE(date, 'DD-MM-YYYY'),
    CAST(stock_received AS smallint),
    CAST(damaged_stock AS smallint)
FROM bronze.blinkit_inventory;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.inventory';
END;

$$;
---=========================================================
--⭐ 5) --marketing_performance
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.marketing_performance';
END;
$$;

INSERT INTO silver.marketing_performance
SELECT
    campaign_id,
    campaign_name,
    TO_DATE(date, 'YYYY-MM-DD'),
    target_audience,
    channel,
    impressions,
    clicks,
    conversions,
    spend,
    revenue_generated
FROM bronze.blinkit_marketing_performance;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.marketing_performance';
END;
$$;
---=========================================================
--⭐ 6) --order_items
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.order_items';
END;
$$;

INSERT INTO silver.order_items
SELECT *
FROM bronze.blinkit_order_items;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.order_items';
END;
$$;
---=========================================================
--⭐ 7) --orders
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.orders';
END;
$$;

INSERT INTO silver.orders
SELECT
    order_id,
    customer_id,
    CAST(order_date AS timestamp),
    CAST(promised_delivery_time AS timestamp),
    CAST(actual_delivery_time AS timestamp),
    delivery_status,
    order_total,
    payment_method,
    delivery_partner_id,
    store_id
FROM bronze.blinkit_orders;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.orders';
END;
$$;
---=========================================================
--⭐ 8) --Products
--=========================================================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Inserting data into silver.products';
END;
$$;

INSERT INTO silver.products
SELECT
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
FROM bronze.blinkit_products;

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Finished loading silver.products';
END;
$$;
