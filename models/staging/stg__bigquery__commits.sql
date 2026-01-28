with source as (
    select * from {{ source('github', 'sample_commits') }}
)

select *,
    current_timestamp() as ingestion_timestamp
from source