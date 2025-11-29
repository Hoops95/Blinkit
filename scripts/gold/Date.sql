---=========================================================
--⭐ 1) --dim_date
--=========================================================

CREATE TABLE gold.dim_date (
    date_key        INTEGER PRIMARY KEY,
    full_date       DATE NOT NULL,
    day             INTEGER,
    month           INTEGER,
    year            INTEGER,
    quarter         INTEGER,
    day_name        VARCHAR(20),
    month_name      VARCHAR(20),
    week_of_year    INTEGER,
    is_weekend      BOOLEAN
);


INSERT INTO gold.dim_date (
    date_key, full_date, day, month, year, quarter,
    day_name, month_name, week_of_year, is_weekend
)
SELECT 
    TO_CHAR(d, 'YYYYMMDD')::INTEGER AS date_key,
    d AS full_date,
    EXTRACT(DAY FROM d)::INTEGER,
    EXTRACT(MONTH FROM d)::INTEGER,
    EXTRACT(YEAR FROM d)::INTEGER,
    EXTRACT(QUARTER FROM d)::INTEGER,
    TO_CHAR(d, 'Day'),
    TO_CHAR(d, 'Month'),
    EXTRACT(WEEK FROM d)::INTEGER,
    CASE WHEN EXTRACT(ISODOW FROM d) IN (6,7) THEN TRUE ELSE FALSE END
FROM 
    generate_series('2023-01-01'::date, '2025-12-31'::date, '1 day') AS d;

