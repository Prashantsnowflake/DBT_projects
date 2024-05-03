{% macro upper_case(column_name) %}

  upper({{column_name}})

{%endmacro%}