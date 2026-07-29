
# retail/e-commerce sales analytics warehouse

<br>

## ❄️🔨 Snowflake Medallion Architecture Data Pipeline (End-to-End ELT Project)

<br>

### 🎯 Business problem: "A retail company has customer, product, and order data but reporting is inconsistent because data is spread across operational sources."

### 🧠 Business use cases: "Which customers are most valuable?, which products sell? and what is the revenue trends over time?"

### 📊 Business Solution: "I built a centralized analytical warehouse in Snowflake that provides a single source of truth for sales reporting."

### 📃 Dont forget to check out my /docs folder in this repository which briefly goes over deep points on why I chose this design architecture, also it's my own learning resource/notes to help me too! 

<br> 

### 📖 Overview

This project demonstrates an end-to-end data engineering pipeline using Snowflake, implementing a medallion architecture (Bronze, Silver, Gold) and a dimensional star schema model for analytics.

The pipeline includes data ingestion, transformation, modelling, and data quality layers designed to simulate a real-world data warehouse environment.

<br>

### 🏗️ Architecture

```mermaid
flowchart TD

A[External Source <br>AWS S3<br/>customers.csv] -->|Extract| B[Bronze Layer<br/>Raw ingestion table<br/>CUSTOMERS_RAW]

B -->|Load| C[Silver Layer<br/>Cleaned & validated<br/>CUSTOMERS_CLEAN]

C -->|Transform| D[Gold Layer<br/>Star Schema Model]

D --> D1[DIM_CUSTOMERS]
D --> D2[DIM_PRODUCTS]
D --> D3[DIM_DATE]
D --> D4[FACT_ORDERS]

D --> E[Data ready for BI / Analytics Layer<br/>Dashboards & KPIs]
```


```
ELT FLOW 

E = Extract
    Extract raw CSV data from AWS S3

L = Load
    Load raw data directly into Snowflake Bronze layer

T = Transform
    Transform data inside Snowflake:
    - Cleaning
    - null checks on keys, duplicate detection, type/format checking 
    - MERGE logic
    - Star schema modelling
    - Aggregations
```


```

ELT PIPELINE
├── Bronze (raw ingestion)
├── Silver (cleaning + data checks)
├── Gold (star schema model)
└── Production Layer
    ├── Logging
    ├── Monitoring
    ├── Alerts (conceptual)
    └── Retry strategy

```


#### ⚙️ Tech Stack

- Snowflake (Data Warehouse)
- SQL (Transformation & Modelling)
- S3 (Data Source)
- Medallion Architecture (Bronze/Silver/Gold)
- Star Schema Data Modelling


#### 🔄 Pipeline Flow

1. Data ingested into Bronze layer (raw data)
2. Cleaned and checked type/format, duplicates, and nulls in Silver layer
3. Transformed into Gold layer (fact + dimension tables)
4. Analytical models created for reporting


#### 🧱 Data Model

- DIM_CUSTOMERS
- DIM_PRODUCTS
- DIM_DATE
- FACT_ORDERS


#### 📊 Key Features

- Medallion architecture implementation
- Star schema design
- Incremental processing logic
- Data quality checks
- Business-ready analytical models


###### 🚀 How to Run

1. Execute scripts in /sql folder in order
2. Load sample data into Snowflake
3. Run Bronze → Silver → Gold pipeline
4. Query Gold layer for analytics


###### 📌 Key Learnings

- Data modelling using star schema
- ELT pipeline design in Snowflake
- Data quality techniques
- Incremental data processing concepts



