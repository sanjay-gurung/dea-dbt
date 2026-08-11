{{
    config
    (
        materialized = 'table'
    )
}}

with customer_src as (
    select 
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE,
    COUNTRY,
    CREATED_AT,
    current_timestamp as insert_dts
    from {{source('customer', 'customer_src')}}
    -- from DBT_DB.PUBLIC.CUSTOMER_SRC
)
select * from customer_src