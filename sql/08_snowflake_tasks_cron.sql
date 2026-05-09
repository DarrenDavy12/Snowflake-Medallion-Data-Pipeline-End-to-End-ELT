-- Pipeline tasks


-- Bronze → Silver


-- CRON JOB 

CREATE OR REPLACE TASK task_silver_load
WAREHOUSE = compute_wh
SCHEDULE = 'USING CRON 0 0 * * * UTC'  -- midnight UTC
AS
INSERT INTO SILVER.CUSTOMERS_CLEAN
SELECT DISTINCT
    ID,
    TRIM(first_name),
    TRIM(last_name),
    LOWER(email),
    age,
    city,
    load_timestamp
FROM BRONZE.CUSTOMERS_RAW;



-- Silver → Gold

CREATE OR REPLACE TASK task_gold_load
WAREHOUSE = compute_wh
AFTER task_silver_load
AS
INSERT INTO GOLD.DIM_CUSTOMERS
SELECT
    ID AS customer_id,
    first_name,
    last_name,
    email,
    city,
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 60 THEN '36-60'
        ELSE '60+'
    END AS age_group
FROM SILVER.CUSTOMERS_CLEAN;



-- Activate pipeline

ALTER TASK task_silver_load RESUME;
ALTER TASK task_gold_load RESUME;