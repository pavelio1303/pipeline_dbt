with source as (
    select * from {{ source('bronze', 'BRZ_POS_PEDIDO_LINEA') }}
),
renamed as (
    select
        upper(trim(pos_id_pedido)) as pos_pedido_id,
        upper(trim(nro_linea)) as linea_id,
        upper(trim(sku)) as sku,
        upper(trim(nombre_producto_en_compra)) as nombre_producto,
        -- Conversión numérica
        try_to_numeric(cantidad, 38, 2) as cantidad,
        try_to_numeric(precio_unitario, 38, 2) as precio_unitario,
        try_to_numeric(descuento_linea, 38, 2) as descuento_importe,
        try_to_numeric(importe_linea, 38, 2) as importe_total_linea
    from source
)
select * from renamed