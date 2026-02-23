with source as (
    select * from {{ source('bronze', 'BRZ_ERP_PEDIDO_LINEA') }}
),
renamed as (
    select
        upper(trim(erp_id_pedido)) as erp_pedido_id,
        upper(trim(nro_linea)) as linea_id,
        upper(trim(erp_id_articulo)) as erp_articulo_id,
        upper(trim(sku)) as sku,
        -- Conversión numérica (coerce)
        try_to_numeric(cantidad_pedida, 38, 2) as cantidad_pedida,
        try_to_numeric(cantidad_reservada, 38, 2) as cantidad_reservada,
        try_to_numeric(cantidad_enviada, 38, 2) as cantidad_enviada,
        try_to_numeric(precio_unitario_erp, 38, 2) as precio_unitario_erp
    from source
)
select * from renamed