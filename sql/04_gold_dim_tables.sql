-- GOLD LAYER 

/* 
Star schema data modelling with creating DIMENSION and FACT tables & Business ready BI / Analytics Layer
Data Modelling - enabling scalable analytical querying, better performance 
*/


-- DIMENSION TABLES
-- create dimension table called DIM_CUSTOMERS in gold layer (who? / what? / when? 'descriptive')
CREATE OR REPLACE TABLE GOLD.DIM_CUSTOMERS AS
SELECT
    ID AS customer_id,
    first_name,
    last_name,
    email,
    city,
    CASE  -- CASE statement 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 60 THEN '36-60'
        ELSE '60+'
    END AS age_group -- age_group column created in table
FROM SILVER.CUSTOMERS_CLEAN;

-- create dimension table called DIM_PRODUCTS in gold layer 
CREATE OR REPLACE TABLE GOLD.DIM_PRODUCTS (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(150),
    price DECIMAL(10,2)
);

INSERT INTO GOLD.DIM_PRODUCTS VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Headphones', 'Electronics', 199.99),
(3, 'Keyboard', 'Accessories', 89.99);

SELECT * FROM GOLD.DIM_PRODUCTS;

-- create dimension table called DIM_DATE in gold layer 
CREATE OR REPLACE TABLE GOLD.DIM_DATE (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

SELECT * FROM GOLD.DIM_DATE;

