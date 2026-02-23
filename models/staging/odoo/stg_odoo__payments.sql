with source as (
    select * from {{ source('odoo_raw', 'RAW_PAYMENTS') }}
)
select
    upper(trim(payment_id)) as payment_id,
    upper(trim(order_id)) as order_id,
    upper(trim(provider)) as payment_method_id, -- Relación con nuestro stg de métodos
    try_to_number(replace(amount, ',', '.')) as amount,
    upper(trim(status)) as status,
    try_to_timestamp(payment_ts) as payment_ts
from source