# Retry Logic (Resilience Concept)

In production systems, failed steps are not manually rerun—they are retried automatically.

Conceptually, retry logic ensures:

transient failures (network, load issues) are retried
pipelines don’t fail permanently on temporary issues
Example behaviour:
Attempt 1 → fail
Retry 1 → fail
Retry 2 → success

This is typically handled in:

orchestration tools (ADF / Airflow)
or task configurations in Snowflake
