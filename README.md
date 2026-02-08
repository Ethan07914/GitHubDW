# GitHub Market Insight & Compliance DW
## Overview
This project takes the public GitHub dataset on BigQuery and models it into a Star Schema.
It provides a single source of truth enabling analysis of market share and open-source legal compliance.

-  __Market Insight:__ Identify which programming languages are gaining popularity.
- __Legal Compliance:__ Track the percentage of repositories utilising a valid license.

## Business Objective
The Data Warehouse focuses on monitoring Market Intelligence and Legal Compliance business processes at GitHub.

- Monitoring Market Intelligence would allow developers to identify which areas to focus their 
feature development on.
- Monitoring Legal Compliance allows GitHub to monitor if open-source
repositories are being used lawfully.


## Dataflow
- __Source:__ BigQuery github_repos public dataset.
- __Staging:__ Relevant tables identified in staging models and written to BigQuery dataset.
- __Warehouse:__ Data transformed into fact and dimension tables into BigQuery data warehouse.


## Tech Stack
- BigQuery (Data Warehouse)
- dbt-core / dbt-bigquery (Transformation)
- Looker Studio (Visualisation)
