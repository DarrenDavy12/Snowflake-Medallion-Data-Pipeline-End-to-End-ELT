# Data Model Explanation

## Overview

This project uses a dimensional modelling approach to support analytical querying and reporting workloads in Snowflake.

The Gold layer follows a star schema design consisting of fact and dimension tables.

---

# Star Schema Design

The star schema was chosen to:

- Simplify analytical queries
- Improve reporting performance
- Separate descriptive attributes from measurable events
- Support scalability for future datasets

---

# Dimension Tables

## DIM_CUSTOMERS

Stores descriptive customer information.

### Columns

- customer_id
- first_name
- last_name
- email
- city
- age_group

### Purpose

Used to describe customer attributes for reporting and segmentation analysis.

---

## DIM_PRODUCTS

Stores product reference data.

### Columns

- product_id
- product_name
- category
- price

### Purpose

Used to categorise and analyse product sales performance.

---

## DIM_DATE

Stores date-related attributes for time-based analysis.

### Columns

- date_id
- year
- month
- day

### Purpose

Supports trend analysis and time-series reporting.

---

# Fact Tables

## FACT_ORDERS

Stores transactional order data.

### Columns

- order_id
- customer_id
- product_id
- order_date
- quantity
- total_amount

### Purpose

Captures measurable business events for analytical reporting.

---

# Relationships

- FACT_ORDERS joins to DIM_CUSTOMERS using customer_id
- FACT_ORDERS joins to DIM_PRODUCTS using product_id
- FACT_ORDERS joins to DIM_DATE using order_date/date_id

---

# Why Dimensional Modelling Was Used

Dimensional modelling improves:

- Query performance
- Readability for analysts
- Dashboard and BI integration
- Scalability for future reporting requirements

This approach aligns with common enterprise data warehouse design practices.
