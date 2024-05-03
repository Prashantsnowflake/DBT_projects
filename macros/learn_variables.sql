{%macro learn_variable() %}

{% set my_first_jinja_variable = "prashant and varsha" %}
{{ log ("welcome to UK "~ my_first_jinja_variable , info = true)}}

{%endmacro%}