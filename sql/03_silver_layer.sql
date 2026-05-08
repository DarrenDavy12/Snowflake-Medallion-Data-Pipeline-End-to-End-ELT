-- SILVER LAYER (cleaning)  

-- silver layer CREATE TABLE (cleaning) 
-- This method removes duplicates temporarily, but doesn’t control updates over time
/* 
CREATE TABLE SILVER.CUSTOMERS_CLEAN AS 
SELECT DISTINCT -- no duplicate 
    ID,
    TRIM(first_name) AS first_name, -- trim any whitespaces
    TRIM(last_name) AS last_name,
    LOWER(email) AS email, -- lowercase letters in emails
    age, 
    city
FROM BRONZE.CUSTOMERS_RAW
WHERE email IS NOT NULL; -- only show records with email address
*/

-- USE THIS METHOD 'MERGE' instead
/* 
MERGE means 'combine INSERT + UPDATE in one operation'
MERGE ensures data consistency by handling both new and existing records efficiently
*/ 
MERGE INTO SILVER.CUSTOMERS_CLEAN target -- SILVER.CUSTOMERS_CLEAN table is the target 
USING (
    SELECT DISTINCT
        ID,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        LOWER(email) AS email,
        age,
        city
    FROM BRONZE.CUSTOMERS_RAW  
    WHERE email IS NOT NULL
) source
ON target.ID = source.ID
WHEN MATCHED THEN UPDATE SET -- if match, update customer and create new if no match (see below: WHEN NOT MATCHED THE INSERT...) 
    target.first_name = source.first_name,
    target.last_name = source.last_name,
    target.email = source.email,
    target.age = source.age,
    target.city = source.city 
WHEN NOT MATCHED THEN INSERT ( -- no match, insert new customer    
    ID, first_name, last_name, email, age, city 
)
VALUES (
    source.ID, source.first_name, source.last_name,
    source.email, source.age, source.city
);

-- validate clean table 
SELECT * FROM SILVER.CUSTOMERS_CLEAN; 


