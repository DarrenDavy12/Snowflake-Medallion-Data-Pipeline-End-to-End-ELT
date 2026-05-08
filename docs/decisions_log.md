# Decisions Log

## Overview

This document outlines key design and implementation decisions made throughout the project.

---

# Decision 1: Medallion Architecture

## Choice

Bronze, Silver, and Gold layered architecture.

## Reason

This structure improves maintainability, scalability, and separation of responsibilities between raw, cleaned, and analytical data.

---

# Decision 2: Star Schema Modelling

## Choice

Dimensional modelling using fact and dimension tables.

## Reason

Star schemas simplify analytical querying and improve compatibility with BI tools.

---

# Decision 3: Use of MERGE Statements

## Choice

MERGE statements were used instead of full table rebuilds.

## Reason

MERGE supports incremental updates and reduces unnecessary reprocessing of existing data.

This approach is more scalable and production-oriented.

---

# Decision 4: Incremental Processing Logic

## Choice

Load timestamps were added to support incremental filtering.

## Reason

Incremental processing improves pipeline performance by only processing newly ingested records.

---

# Decision 5: Data Quality Validation

## Choice

Validation checks were implemented across pipeline layers.

## Reason

Data quality checks improve reliability and help detect duplicates, missing values, and integrity issues early in the pipeline.

---

# Decision 6: Separation of SQL Scripts

## Choice

SQL logic was separated into modular scripts.

## Reason

This improves readability, maintainability, and deployment organisation.

---

# Lessons Learned

Key learning areas during the project included:

- Medallion architecture design
- Dimensional data modelling
- Incremental pipeline design
- MERGE/upsert logic
- Data quality validation strategies
- Snowflake ELT workflows
