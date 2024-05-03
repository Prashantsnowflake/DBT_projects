{{
  config(
    materialized='incremental',
    on_schema_change= 'fail'
  )
}}
WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }}
)
SELECT 
{{ dbt_utils.generate_surrogate_key(['LISTING_ID', 'REVIEW_DATE','REVIEWER_NAME']) }} as review_id
,
* FROM src_reviews
WHERE review_text IS NOT NULL

{%- if is_incremental() %}
AND review_date > (select max(review_date) from {{ this }})
{%- endif %}
