-- One row per opportunity; lead attributes are linked through its account.
with lifecycle as (
    select * from {{ ref('int_lead_lifecycle') }}
)

select
    opportunity_id,
    account_id,
    account_name,
    opportunity_created_at,
    opportunity_closed_at,
    cast(opportunity_created_at as date) as opportunity_created_date,
    cast(opportunity_closed_at as date) as opportunity_closed_date,
    date_trunc('month', opportunity_closed_at) as opportunity_closed_month,
    is_closed,
    is_won,
    lead_source,
    job_title as primary_contact_job_title,
    account_industry as industry,
    account_fleet_size as fleet_size,
    lead_country as country,
    lead_state as state,
    lead_city as city,
    case
        when is_closed and opportunity_closed_at is not null
            then date_diff('day', opportunity_created_at, opportunity_closed_at)
    end as days_to_close
from lifecycle
where opportunity_id is not null
