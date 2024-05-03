{% test check_min_night_more_than_1k(model, column_name) %}


select * from {{ model }}  where {{ column_name }}  > 1200

{% endtest %}