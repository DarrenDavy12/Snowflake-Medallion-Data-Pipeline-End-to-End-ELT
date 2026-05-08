-- How does the pipeline avoid reprocessing everything every run?


/*

Without incremental + MERGE:

- pipelines become slow
- duplicate data happens
- full refreshes waste compute

With it:

- scalable
- production-like
- reliable

*/


-- timestamp column
ALTER TABLE BRONZE.CUSTOMERS_RAW
ADD COLUMN load_timestamp TIMESTAMP;



-- Populate timestamps
UPDATE BRONZE.CUSTOMERS_RAW
SET load_timestamp = CURRENT_TIMESTAMP
WHERE load_timestamp IS NULL;



-- Incremental filtering logic
-- only process new rows
SELECT *
FROM BRONZE.CUSTOMERS_RAW
WHERE load_timestamp >
(
    SELECT COALESCE(MAX(load_timestamp), '1900-01-01')
    FROM SILVER.CUSTOMERS_CLEAN
);



-- MERGE 

/* 
| Situation       | Action |
| --------------- | ------ |
| Customer exists | UPDATE |
| Customer new    | INSERT |

*/

MERGE INTO SILVER.CUSTOMERS_CLEAN target
USING (
    SELECT DISTINCT
        ID,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        LOWER(email) AS email,
        age,
        city,
        load_timestamp
    FROM BRONZE.CUSTOMERS_RAW
    WHERE email IS NOT NULL
) source
ON target.ID = source.ID

WHEN MATCHED THEN UPDATE SET
    target.first_name = source.first_name,
    target.last_name = source.last_name,
    target.email = source.email,
    target.age = source.age,
    target.city = source.city,
    target.load_timestamp = source.load_timestamp

WHEN NOT MATCHED THEN INSERT (
    ID,
    first_name,
    last_name,
    email,
    age,
    city,
    load_timestamp
)
VALUES (
    source.ID,
    source.first_name,
    source.last_name,
    source.email,
    source.age,
    source.city,
    source.load_timestamp
);