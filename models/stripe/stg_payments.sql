{{ config(schema_test='tests/numeric_positive_test.sql') }}


select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
     amount,
    created as created_at
    , discount_code
    ,discount_amount

from {{ source('source_stripe','payment')}}