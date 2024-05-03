WITH src_hosts AS (
    SELECT
        *
    FROM
        {{ ref('src_hosts') }}
)
SELECT
    host_id,
    NVL(
        host_name,
        'Anonymous'
    ) AS host_name, 
    is_superhost,
    created_at,
    updated_at , {{ coffee_check('host_id')}} as  coffee_flag
    , {{ country_check('is_superhost')}} as  new_superhost
FROM
    src_hosts
