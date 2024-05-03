{{
    config(materialized='incremental' , unique_key='order_id' )
}}

select
* , current_timestamp() _ETL_LOADED_AT 
from {{ ref('stg_orders') }}

--{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  where ORDER_DATE >= (select NVL( max(ORDER_DATE) , '1900-01-01') from {{ this }})
{% endif %}