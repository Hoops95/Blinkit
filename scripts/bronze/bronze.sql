select table_name
from information_schema.tables
where table_schema='bronze';

select *
from bronze.blinkit_products
limit 60
;