{{ 
    config 
    (
        materialized = 'table'
    )
}}

with session_src as(
    select 
    SESSION_ID, 
    USER_ID, BROWSER, 
    DEVICE_TYPE, 
    b.country_name as country_name, 
    b.continent as continent,
    b.currency as currency,
    START_TIME, 
    END_TIME, 
    PAGES_VISITED,
    current_timestamp as insert_dts
    from {{source('session','session_src')}} a 
    left join {{ref('country_code')}} b
    on a.country_code = b.country_code
)
select * from session_src