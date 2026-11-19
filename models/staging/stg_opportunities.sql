with source as (
    
    select * from {{ ref('opportunities') }}
    
),

renamed as (

    select
        id as opportunity_id,
        account_id,
        cast(created_at as timestamp) as opportunity_created_at,
        cast(closed_at as timestamp) as opportunity_closed_at,
        cast(is_closed as boolean) as is_closed,
        cast(is_won as boolean) as is_won,
        country,
        state,
        city
    from source

)

select * from renamed
