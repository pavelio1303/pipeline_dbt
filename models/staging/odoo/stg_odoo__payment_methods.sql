with source as (
    select distinct 
        provider, 
        card_brand 
    from {{ source('odoo_raw', 'RAW_PAYMENTS') }}
)
select
    -- Creamos un ID único para el método
    upper(trim(provider)) as payment_method_id,
    upper(trim(provider)) as method_name,
    upper(trim(card_brand)) as card_network
from source
where provider is not null