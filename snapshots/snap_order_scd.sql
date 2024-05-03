{% snapshot orders_snapshot %}

{{
    config(
      target_database='analytics',
      target_schema='scds',
      unique_key='order_id',

      strategy ='check',
      check_cols = ['CUSTOMER_ID', 'status'] ,
      invalidate_hard_deletes=True
    )
}}

select * from {{ ref('increment_order_with_key') }}

{% endsnapshot %}