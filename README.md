Snowflake Medallion Architecture Data Pipeline (End-to-End ELT Project)


📖 Overview

This project demonstrates an end-to-end data engineering pipeline using Snowflake, implementing a medallion architecture (Bronze, Silver, Gold) and a dimensional star schema model for analytics.

The pipeline includes data ingestion, transformation, modelling, and validation layers designed to simulate a real-world data warehouse environment.


🏗️ Architecture

```mermaid
flowchart TD

A -->[External Source: AWS S3<br/>customers.csv] -->|Extract| B[Bronze Layer<br/>Raw ingestion table<br/>CUSTOMERS_RAW]

B -->|Load| C[Silver Layer<br/>Cleaned & validated<br/>CUSTOMERS_CLEAN]

C -->|Transform| D[Gold Layer<br/>Star Schema Model]

D --> D1[DIM_CUSTOMERS]
D --> D2[DIM_PRODUCTS]
D --> D3[DIM_DATE]
D --> D4[FACT_ORDERS]

D --> E[Data ready for BI / Analytics Layer<br/>Dashboards & KPIs]
```

ELT FLOW 

E = Extract
    Extract raw CSV data from AWS S3

L = Load
    Load raw data directly into Snowflake Bronze layer

T = Transform
    Transform data inside Snowflake:
    - Cleaning
    - Validation
    - MERGE logic
    - Star schema modelling
    - Aggregations



⚙️ Tech Stack

- Snowflake (Data Warehouse)
- SQL (Transformation & Modelling)
- S3 (Data Source simulation)
- Medallion Architecture (Bronze/Silver/Gold)
- Star Schema Data Modelling


🔄 Pipeline Flow

1. Data ingested into Bronze layer (raw data)
2. Cleaned and validated in Silver layer
3. Transformed into Gold layer (fact + dimension tables)
4. Analytical models created for reporting


🧱 Data Model

- DIM_CUSTOMERS
- DIM_PRODUCTS
- DIM_DATE
- FACT_ORDERS


📊 Key Features

- Medallion architecture implementation
- Star schema design
- Incremental processing logic
- Data quality validation checks
- Business-ready analytical models


🚀 How to Run

1. Execute scripts in /sql folder in order
2. Load sample data into Snowflake
3. Run Bronze → Silver → Gold pipeline
4. Query Gold layer for analytics


📌 Key Learnings

- Data modelling using star schema
- ELT pipeline design in Snowflake
- Data quality and validation techniques
- Incremental data processing concepts



