{% macro coffee_check(column_name) %}
 
 {# this should be check as discound code is 51 then 'Yes' else 'NO' end 
    was to calculate Coffee_subscription_redemption_flag
                     Coffee_subscription_redemptio_flag
  few example -
  ,case when final_data.DISCOUNT_REASON_CODE = 51 then 'Yes' else 'No' end COFFEE_SUBSCRIPTION_REDEMPTION_FLAG
  ,case when final_data.DISCOUNT_REASON_CODE = 51 then 'Yes' else 'No' end COFFEE_SUBSCRIPTION_ATTACHMENT_FLAG
  ,case when final_data.Country_Code = 826 then 'UK'
      When final_data.country_code  = 372 then 'IE                               #}

  case when {{column_name}} = 1581 then 'Yess' else 'Nooo' end 

{%endmacro%}

{# this is another example that you can write another macro in same file 
importanat is macro name #}

{% macro country_check(column_name) %}

  case when {{column_name}} = 'f' then 'GB' else {{column_name}} end 

{%endmacro%}