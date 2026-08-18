{{ 
    config
    (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'purchase_id',
        merge_exclude_columns = ['insert_dts']
    )
}}

with purchase_src as (
    select PURCHASE_ID, PURCHASE_DATE, PURCHASE_STATUS, CREATED_AT, 
    current_timestamp as insert_dts,
    current_timestamp as update_dts
    from {{source('purchase', 'purchase_src')}}

    {% if is_incremental() %}
    where created_at > (select max(update_dts) from {{this}})
    {% endif %}
)
select * from purchase_src