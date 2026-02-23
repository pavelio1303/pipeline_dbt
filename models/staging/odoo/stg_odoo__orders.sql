with source as (
    select * from {{ source('odoo_raw', 'RAW_ORDERS') }}
)
select
    upper(trim(order_id)) as order_id,
    upper(trim(status)) as status,
    upper(trim(customer_id)) as customer_id,
    try_to_number(replace(total, ',', '.')) as total_amount,
    try_to_timestamp(order_ts) as order_ts
from source