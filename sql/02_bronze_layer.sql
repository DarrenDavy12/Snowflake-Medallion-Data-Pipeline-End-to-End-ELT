-- BRONZE LAYER (extract)

/* 
Extract data from s3 bucket into new table in snowflake database
*/

-- create bronze table in bronze schema (raw data) 
CREATE TABLE BRONZE.CUSTOMERS_RAW (
    ID int,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(255),
    age int,
    city varchar(255)
);

/* 
SKIP_HEADER is NOT stored permanently in the table
It only applies during that specific COPY INTO execution
*/

-- extract from source into "BRONZE.CUSTOMERS_RAW" table, (in this case aws s3 bucket)
COPY INTO BRONZE.CUSTOMERS_RAW
    FROM s3://snowflake-assignments-mc/gettingstarted/customers.csv
    file_format = (type = csv -- format is csv 
                    field_delimiter = ',' -- comma separated for csv's
                    skip_header = 1); -- skip first header to load column headers as the first row

                    
-- validate raw data extraction 
SELECT * FROM BRONZE.CUSTOMERS_RAW; -- select all rows from table 

-- check duplicates in raw data
SELECT 
    ID, 
    COUNT(*)
FROM BRONZE.CUSTOMERS_RAW
GROUP BY ID
HAVING COUNT(*) > 1; 


-- check missing emails 
SELECT 
    *
FROM BRONZE.CUSTOMERS_RAW
WHERE email IS NULL;

-- usually it is best practice to define timestamp column in ingestion stage when creating BRONZE.CUSTOMERS_RAW
-- added TIMESTAMP to BRONZE.CUSTOMERS_RAW
ALTER TABLE BRONZE.CUSTOMERS_RAW
ADD COLUMN load_timestamp TIMESTAMP;


-- set TIMESTAMP to CURRENT_TIMESTAMP
UPDATE BRONZE.CUSTOMERS_RAW
SET load_timestamp = CURRENT_TIMESTAMP
WHERE load_timestamp IS NULL;


-- made ID column a primary key 
ALTER TABLE BRONZE.CUSTOMERS_RAW
ADD PRIMARY KEY (ID);

-- confirm changes
DESC TABLE BRONZE.CUSTOMERS_RAW;
