{{
    config 
    (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with sales_src as (
    select SALE_ID, SALE_DATE, CUSTOMER_ID, PRODUCT_ID, QUANTITY, TOTAL_AMOUNT,CREATED_AT, CURRENT_TIMESTAMP AS INSERT_DTS
    from {{source('sales', 'sales_src')}}
    -- from dbt_db.public.sales_src

    {% if is_incremental() %}
    where created_at > (select max(insert_dts) from {{this}})
    {% endif %}
)
select * from sales_src