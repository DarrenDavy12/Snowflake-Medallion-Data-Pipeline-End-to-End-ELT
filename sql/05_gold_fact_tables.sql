-- FACT TABLES
-- create fact table called FACT_CUSTOMER_ACTIVITY (event - what happened? 'measurable')
CREATE OR REPLACE TABLE GOLD.FACT_CUSTOMER_ACTIVITY AS
SELECT
    ID AS customer_id,
    COUNT(*) AS activity_count,
    CURRENT_DATE AS snapshot_date
FROM SILVER.CUSTOMERS_CLEAN
GROUP BY ID;


-- create fact table called FACT_ORDERS
CREATE OR REPLACE TABLE GOLD.FACT_ORDERS (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2)
);


INSERT INTO GOLD.FACT_ORDERS VALUES
(1, 1, 1, '2025-01-01', 1, 999.99),
(2, 1, 2, '2025-01-02', 2, 399.98),
(3, 2, 3, '2025-01-03', 1, 89.99);


SELECT * FROM GOLD.FACT_ORDERS;


CREATE TABLE GOLD.CUSTOMERS AS 
SELECT 
    ID,
    first_name,
    last_name,
    email,
    age,
    city,
CASE -- case statement 
    WHEN age < 18 THEN 'Under 18' 
    WHEN age BETWEEN 18 AND 35 THEN '18-35'
    WHEN age BETWEEN 35 AND 60 THEN '35-60'
    ELSE '60+'
    END AS age_group 
FROM SILVER.CUSTOMERS_CLEAN;


-- validate gold table
SELECT * FROM GOLD.CUSTOMERS;


-- analytical engineering - aggregations
-- (total customers per age group)
CREATE TABLE GOLD.CUSTOMER_INSIGHTS AS 
SELECT   
    age_group,
    COUNT(*) AS total_customers
FROM GOLD.CUSTOMERS
GROUP BY age_group;

SELECT * FROM GOLD.CUSTOMER_INSIGHTS;



