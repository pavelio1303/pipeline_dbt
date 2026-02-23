with source as (
    select distinct 
        customer_id, 
        customer_email, 
        ship_city 
    from {{ source('odoo_raw', 'RAW_ORDERS') }}
)
select
    upper(trim(customer_id)) as customer_id,
    upper(trim(customer_email)) as email,
    upper(trim(ship_city)) as city
from source
where customer_id is not null