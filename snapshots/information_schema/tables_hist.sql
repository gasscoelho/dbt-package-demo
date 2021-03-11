{% snapshot tables_hist %}
    {{
        config(
          strategy='check',
          check_cols='all',
          unique_key = 'dwhash_key',
          tags = ['information_schema']
        )
    }}

    select
        sha2(array_to_string(array_construct(table_catalog, table_schema, table_name), '^^^')) as dwhash_key 
        , * 
    from {{ source('information_schema', 'tables') }}
    
{% endsnapshot %}
