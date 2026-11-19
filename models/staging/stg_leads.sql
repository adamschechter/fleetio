with source as (
    
    select * from {{ ref('leads') }}

),

renamed as (

    select
        id as lead_id,
        first_name,
        last_name,
        job_title,
        email,
        company,
        cast(created_at as timestamp) as lead_created_at,
        cast(converted_at as timestamp) as lead_converted_at,
        source as lead_source,
        country,
        state,
        city,
        industry,
        fleet_size
    from source

)

select * from renamed


