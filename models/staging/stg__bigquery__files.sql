with source as (
    select * from {{ source('github', 'sample_files') }}
)

select *,
    current_timestamp() as ingestion_timestamp
from source