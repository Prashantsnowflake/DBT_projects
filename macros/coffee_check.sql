{% macro coffee_check(column_name) %}

  case when {{column_name}} = 1581 then 'Yess' else 'Nooo' end 

{%endmacro%}


{% macro country_check(column_name) %}

  case when {{column_name}} = 'f' then 'GB' else {{column_name}} end 

{%endmacro%}