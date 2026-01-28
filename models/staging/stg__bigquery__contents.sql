with source as (
    select * from {{ source('github', 'sample_contents') }}
)

select *,
    current_timestamp() as ingestion_timestamp
from source