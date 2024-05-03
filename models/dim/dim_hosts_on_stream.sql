{{
  config(
    materialized='incremental',
    on_schema_change= 'fail'
  )
}}

WITH src_hosts_stream_table AS (
    SELECT
        *
    FROM
        {{ ref('src_hosts_stream') }}
)   
SELECT
    * from src_hosts_stream_table