with leads as (
    
    select * from {{ ref('stg_leads') }}
    
),

contacts as (
    
    select * from {{ ref('stg_contacts') }}

),

accounts as (
    
    select * from {{ ref('stg_accounts') }}

),

opportunities as (

    select * from {{ ref('stg_opportunities') }}

),

final as (
    select
        leads.lead_id,
        leads.job_title,
        leads.lead_created_at,
        leads.lead_converted_at,
        leads.lead_source,
        leads.country as lead_country,
        leads.state as lead_state,
        leads.city as lead_city,
        leads.industry as lead_industry,
        leads.fleet_size as lead_fleet_size,
        contacts.contact_id,
        accounts.account_id,
        accounts.account_name,
        accounts.industry as account_industry,
        accounts.fleet_size as account_fleet_size,
        opportunities.opportunity_id,
        opportunities.opportunity_created_at,
        opportunities.opportunity_closed_at,
        opportunities.is_closed,
        opportunities.is_won
    from leads
    left join contacts on leads.lead_id = contacts.lead_id
    left join accounts on contacts.account_id = accounts.account_id
    left join opportunities on accounts.account_id = opportunities.account_id

),

select * from final

