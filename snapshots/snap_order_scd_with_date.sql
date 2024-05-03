{% snapshot orders_snapshot_with_date %}

{{
    config(
      target_database='analytics',
      target_schema='scds',
      unique_key='order_id',

      strategy ='timestamp',
      updated_at='_ETL_LOADED_AT',
      invalidate_hard_deletes=True
    )
}}

select * ,current_timestamp() cts,'test' test_col , 'test' test_col_2 from {{ ref('increment_order_with_date') }}

{% endsnapshot %}