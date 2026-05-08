/* 
Implemented data quality validation checks to ensure consistency, detect duplicates, validate business rules, 
and maintain referential integrity across fact and dimension tables.
*/


-- Row count validation
SELECT COUNT(*) FROM BRONZE.CUSTOMERS_RAW;
SELECT COUNT(*) FROM SILVER.CUSTOMERS_CLEAN;
SELECT COUNT(*) FROM GOLD.CUSTOMERS;


-- check duplicate customer IDs
SELECT 
    ID,
    COUNT(*) AS duplicate_count
FROM SILVER.CUSTOMERS_CLEAN
GROUP BY ID
HAVING COUNT(*) > 1;


-- check missing emails
SELECT *
FROM SILVER.CUSTOMERS_CLEAN
WHERE email IS NULL;


-- invalid ages
SELECT *
FROM SILVER.CUSTOMERS_CLEAN
WHERE age < 0;


-- Referential integrity check
-- Once you have fact + dimension tables
-- orders with missing customers
SELECT *
FROM GOLD.FACT_ORDERS f
LEFT JOIN GOLD.DIM_CUSTOMERS d
    ON f.customer_id = d.customer_id
WHERE d.customer_id IS NULL;


