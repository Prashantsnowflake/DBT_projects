select * from {{ ref('stg_payments') }}
where discount_code  <> 0
and discount_amount = 0
and 1 = 2