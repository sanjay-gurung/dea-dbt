{{ 
    config 
    (
        materialized = 'ephemeral'
    )
}}

with base_orders as (
    select ORDER_ID,ORDER_DATE,CUSTOMER_ID,
    case when customer_name is null then 'NA'
        else upper(customer_name) end as customer_name,
    CREATED_AT
    from {{source('orders', 'base_orders')}}
    where order_date is not null
)
select * from base_orders
