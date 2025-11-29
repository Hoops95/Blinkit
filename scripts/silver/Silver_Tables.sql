-- =======================
-- Loading Table: customer_feedback
-- =======================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.customer_feedback';
END;
$$;
CREATE TABLE IF NOT EXISTS silver.customer_feedback (
    feedback_id BIGINT,
    order_id BIGINT,
    customer_id BIGINT,
    rating SMALLINT,
    feedback_text TEXT,
    feedback_category TEXT,
    sentiment TEXT,
    feedback_date TIMESTAMP
);
-- =======================
-- Loading Table: customers
-- =======================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.customers';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.customers (
    customer_id BIGINT,
    customer_name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    area TEXT,
    pincode TEXT,
    registration_date DATE,
    total_orders INT,
    avg_order_value NUMERIC
);
-- =======================
-- Loading Table: Delivery
-- =======================

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.delivery';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.delivery (
    order_id BIGINT,
    delivery_partner_id BIGINT,
    promised_time TIMESTAMP,
    actual_time TIMESTAMP,
    delivery_time_minutes INT,
    distance_km NUMERIC,
    delivery_status TEXT,
    reasons_if_delayed TEXT,
    is_delayed_flag BOOLEAN
);
-- =======================
-- Loading Table: Inventory
-- =======================

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.inventory';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.inventory (
    product_id BIGINT,
    received_date DATE,
    stock_received SMALLINT,
    damaged_stock SMALLINT
);
-- =======================
-- Loading Table: marketing_performance
-- =======================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.marketing_performance';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.marketing_performance (
    campaign_id BIGINT,
    campaign_name TEXT,
    campaign_date DATE,
    target_audience TEXT,
    channel TEXT,
    impressions INT,
    clicks INT,
    conversions INT,
    spend NUMERIC,
    revenue_generated NUMERIC
);
-- =======================
-- Loading Table: order_items

DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.order_items';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.order_items (
    order_id BIGINT,
    product_id BIGINT,
    quantity INT,
    price NUMERIC
);
-- =======================
-- Loading Table: Orders
-- =======================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.orders';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.orders (
    order_id BIGINT,
    customer_id BIGINT,
    order_date TIMESTAMP,
    promised_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_status TEXT,
    order_total NUMERIC,
    payment_method TEXT,
    delivery_partner_id BIGINT,
    store_id BIGINT
);
-- =======================
-- Loading Table: Products
-- =======================
DO LANGUAGE plpgsql
$$
BEGIN
    RAISE NOTICE 'Creating table: silver.products';
END;
$$;

CREATE TABLE IF NOT EXISTS silver.products (
    product_id BIGINT,
    product_name TEXT,
    category TEXT,
    brand TEXT,
    price NUMERIC,
    mrp NUMERIC,
    margin_percentage NUMERIC,
    shelf_life_days INT,
    min_stock_level INT,
    max_stock_level INT
);
