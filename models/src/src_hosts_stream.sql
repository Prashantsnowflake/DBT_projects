
WITH raw_hosts AS (

    SELECT * from {{ source('source_name_airbnb','HOSTS_stream')}}
    where METADATA$ISUPDATE = 'FALSE' and METADATA$ACTION = 'INSERT'
)
SELECT
    {# id AS host_id,
    NAME AS host_name,
    is_superhost,
    created_at,
    updated_at ,* #}*
FROM
    raw_hosts