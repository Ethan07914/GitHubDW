# GitHub Market Insight & Compliance DW
## Overview
This project takes the public GitHub dataset on BigQuery and models it into a Star Schema.
It provides a single source of truth, enabling analysis of market share and open-source legal compliance.

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

## Dashboard
- A paginated report was created using Looker Studio connected to the BigQuery data warehouse.
- Advanced data visualisations were used to report on Market Intelligence and Legal Compliance.
<img width="1078" height="809" alt="image" src="https://github.com/user-attachments/assets/6e29f80c-099d-4e9c-8faa-0f94cb263dc7" />

<img width="1079" height="810" alt="image" src="https://github.com/user-attachments/assets/b97c9654-d4e8-4146-bfaa-2fe4f9b9e715" />

## Data Model
- Conceptual, Logical and Physical data models were created using draw.io.
<img width="1206" height="819" alt="image" src="https://github.com/user-attachments/assets/4997dd44-da0d-4674-b101-60582ed6951d" />



