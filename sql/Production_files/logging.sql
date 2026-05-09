--  Pipeline Logging



CREATE TABLE CONTROL.PIPELINE_LOG (
    pipeline_name STRING,
    layer STRING,
    status STRING,
    rows_affected INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    error_message STRING
);



-- Example insert (success run)

INSERT INTO CONTROL.PIPELINE_LOG
VALUES (
    'CUSTOMER_PIPELINE',
    'SILVER',
    'SUCCESS',
    1000,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    NULL
);\



-- Example insert (failure tracking concept)


INSERT INTO CONTROL.PIPELINE_LOG
VALUES (
    'CUSTOMER_PIPELINE',
    'GOLD',
    'FAILED',
    0,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    'Null value error in FACT table load'
);



