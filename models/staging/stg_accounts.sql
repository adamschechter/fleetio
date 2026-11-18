with source as (
    select * from {{ ref('accounts') }}
)

select
    id as account_id,
    company as account_name,
    primary_contact_id,
    country,
    state,
    city,
    industry,
    fleet_size
from source
