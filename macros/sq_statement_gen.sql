-- macro that generates SQ models

{% macro sq_statement_gen(src, src_model, _DEDUPLICATE_ORDER = 'DEDUPLICATE_ORDER',
                            _IGNORE_IN_SK = 'IGNORE_IN_SK', _DTYPE = 'DTYPE',
                            _EXPRESSION = 'EXPRESSION', _PARTITION = 'PARTITION') %}
-- depends on: {{ source(src, src_model) }}
{%- if execute -%}
    {%- set src_model = source(src, src_model) -%}

    {# get list of fields that will be ignored in surrogate_key function #}
    {% set ignore_objs = get_meta_objs(model.unique_id, _IGNORE_IN_SK) %}
    {%- set model_flds = get_flds(src_model, ignore_objs) -%}

    {# get basic conversion build and build basic conversion statement #}
    {% set basic_convert_objs = get_meta_objs(model.unique_id, _DTYPE) %}
    {% set basic_convert_stm = generate_basic_conversion(basic_convert_objs) %}

    {# get custom expression fields and build custom expression tables #}
    {% set expression_objs = get_meta_objs(model.unique_id, _EXPRESSION) %}
    {% set expression_stm = generate_custom_conversion(expression_objs) %} 

    {# combine basic & custom convsersion fields -> to be exclude after select * statement #}
    {% set convert_objs = combine_dict(basic_convert_objs, expression_objs) %}
    {% set model_objs = get_query_results_as_obj(get_fld_stm(src_model)) %}
    {% set convert_objs = get_intercept_objs(convert_objs, model_objs)%}
    {% set convert_flds = get_flds_from_objs(convert_objs) %}
    {% set exclude_stm = ', '.join(convert_flds)%}

    {# get partition field and build partition statement #}
    {% set partition_objs = get_meta_objs(model.unique_id, _PARTITION) %}
    {% set partition_flds = get_flds_value_from_objs(partition_objs, ' ') %}
    {% set partition_stm = ', '.join(partition_flds) %}

    {# get deduplicate order field and build deduplicate order statement #}
    {% set deduplicate_order_objs = get_meta_objs(model.unique_id, _DEDUPLICATE_ORDER) %} 
    {% set deduplicate_order_flds = get_flds_value_from_objs(deduplicate_order_objs, ' ') %}
    {% set deduplicate_order_stm = ', '.join(deduplicate_order_flds) %}

    {{ sq_select_gen(src_model, model_flds, exclude_stm, basic_convert_stm, 
                        expression_stm, partition_stm, deduplicate_order_stm) }}

{%- endif -%}
{% endmacro %}

{% macro sq_select_gen(src_model, model_flds, exclude_stm, basic_convert_stm,
                        expression_stm, partition_stm, deduplicate_order_stm) %}
    with source_enhanced as (
    SELECT
        *
        {{'EXCLUDE (' ~ exclude_stm ~ ')' if exclude_stm }},
        -- normal expression
        {{ basic_convert_stm ~ ',' if basic_convert_stm }}
        -- custom expression
        {{ expression_stm ~ ',' if expression_stm }}
        -- surrogate key
        {{ dbt_utils.generate_surrogate_key(model_flds) }} AS sq_surrogate_key
    from {{ src_model }}
    QUALIFY row_number() over (partition by sq_surrogate_key order by {{ deduplicate_order_stm }}) = 1)
    select * from source_enhanced
    order by {{ partition_stm }}
{%- endmacro -%}