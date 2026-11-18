-- Daily converted-lead counts by source, ready for BI time-series charts.
with lead_conversions as (
    select * from {{ ref('fct_lead_conversion') }}
)

select
    lead_converted_date as conversion_date,
    lead_converted_week as conversion_week,
    lead_converted_month as conversion_month,
    lead_source,
    count(*) as converted_leads
from lead_conversions
where is_converted
group by 1, 2, 3, 4
