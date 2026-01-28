with source as (
    select * from {{ source('github', 'languages') }}
)

select *,
    current_timestamp() as ingestion_timestamp
from source