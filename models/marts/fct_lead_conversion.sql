-- One row per lead. Use this model for lead-conversion analysis.
with lifecycle as (
    select * from {{ ref('int_lead_lifecycle') }}
)

select
    lead_id,
    lead_created_at,
    lead_converted_at,
    cast(lead_created_at as date) as lead_created_date,
    cast(lead_converted_at as date) as lead_converted_date,
    date_trunc('week', lead_converted_at) as lead_converted_week,
    date_trunc('month', lead_converted_at) as lead_converted_month,
    lead_source,
    job_title,
    lead_country as country,
    lead_state as state,
    lead_city as city,
    lead_industry as industry,
    lead_fleet_size as fleet_size,
    lead_converted_at is not null as is_converted,
    case
        when lead_converted_at is not null
            then date_diff('minute', lead_created_at, lead_converted_at)
    end as minutes_to_conversion
from lifecycle
