with source as (
    select * from {{ ref('contacts') }}
)

select
    id as contact_id,
    first_name,
    last_name,
    job_title,
    email,
    account_id,
    lead_id,
    cast(created_at as timestamp) as contact_created_at
from source
