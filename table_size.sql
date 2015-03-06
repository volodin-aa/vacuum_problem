select pg_total_relation_size( quote_ident( table_schema ) || '.' || quote_ident( table_name ) ) as total_size  
  from information_schema.tables 
  where 
    table_type = 'BASE TABLE' and 
    table_schema = :table_schema and
    table_name = :table_name;

