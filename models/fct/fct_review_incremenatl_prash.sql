{{
  config(
    materialized='incremental',
    on_schema_change= 'fail' , unique_key='listing_id'
  )
}}
WITH src_reviews AS (
  SELECT * FROM AIRBNB.RAW.RAW_REVIEWS_10
)
SELECT * FROM src_reviews

{# {%- if is_incremental() %}
AND review_date > (select max(review_date) from {{ this }})
{%- endif %} #}
