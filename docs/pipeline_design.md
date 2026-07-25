# Pipeline Design

## Overview

This project implements an end-to-end ELT pipeline in Snowflake using a medallion architecture approach.

The pipeline is structured into Bronze, Silver, and Gold layers to separate raw ingestion, transformation, and analytical modelling responsibilities.

---

# Architecture Overview

Data Source → Bronze → Silver → Gold → Analytics

---

# Bronze Layer

## Purpose

The Bronze layer stores raw ingested data from external sources without modification.

## Key Characteristics

- Raw data ingestion
- Minimal transformation
- Historical preservation
- Load timestamp tracking

## Table

- CUSTOMERS_RAW

## If it breaks, how would you know? How would you recover?

"Duplicates would cause x — we'd catch it with y check"
"If the load fails partway, we'd truncate/swap/retry to stay consistent"
"Timestamps let us track when each batch came in"
"Run/batch/file_name IDs let us trace data back to its source file"

---

# Silver Layer

## Purpose

The Silver layer cleans, validates, and standardises raw data.

## Transformations

- Duplicate removal
- NULL filtering
- String trimming
- Email standardisation
- Data quality validation

## Table

- CUSTOMERS_CLEAN

---

# Gold Layer

## Purpose

The Gold layer contains business-ready analytical models.

## Components

- Dimension tables
- Fact tables
- Aggregated reporting models

## Tables

- DIM_CUSTOMERS
- DIM_PRODUCTS
- DIM_DATE
- FACT_ORDERS

---

# Incremental Processing

The pipeline includes load timestamp tracking to support incremental processing logic.

This reduces unnecessary reprocessing and improves scalability.

---

# Data Quality Validation

Validation checks were implemented to ensure:

- No duplicate customer IDs
- No invalid records
- Referential integrity between fact and dimension tables
- Consistent row counts across layers

---

# Future Improvements

Potential future enhancements include:

- Pipeline orchestration using Azure Data Factory
- Automated scheduling
- CI/CD integration
- Monitoring and alerting
- Power BI dashboard integration
