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
    city varchar(255), 
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Now the timestamp is set the moment each row is inserted, automatically. No manual UPDATE needed.
    -- Usually it is best practice to define timestamp column in ingestion stage when creating BRONZE.CUSTOMERS_RAW
);

/* 
SKIP_HEADER is NOT stored permanently in the table
It only applies during that specific COPY INTO execution
*/

-- clean the 'BRONZE.CUSTOMERS_RAW' table for every run using 'TRUNCATE' then extract from source using 'COPY INTO' "BRONZE.CUSTOMERS_RAW" table, (in this case aws s3 bucket).  
-- design choice here depends here "should Bronze keep history of every load, or just the latest?" Most real pipelines: just the latest (stateless). Some: keep everything (append-only audit log).

-- choice: reload on every run because i'm not working with large datasets.
TRUNCATE TABLE BRONZE.CUSTOMERS_RAW;

COPY INTO BRONZE.CUSTOMERS_RAW 
    FROM s3://snowflake-assignments-mc/gettingstarted/customers.csv
    file_format = (type = csv -- format is csv 
                    field_delimiter = ',' -- comma separated for csv's
                    skip_header = 1); -- skip first header to load column headers as the first row

                    
-- validate raw data extraction 
SELECT * FROM BRONZE.CUSTOMERS_RAW 
LIMIT 5; -- select first 5 rows from table 

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


-- confirm changes
DESC TABLE BRONZE.CUSTOMERS_RAW;
