with source as (
    select * from {{ source('github', 'licenses') }}
)

select *,
    current_timestamp() as ingestion_timestamp
from source