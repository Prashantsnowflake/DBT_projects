

with orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status , 'test new col' new_columns

        from {{ source('source_jaffle_shop','orders')}}
)
select * from orders