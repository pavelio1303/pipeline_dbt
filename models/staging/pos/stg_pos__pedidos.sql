with source as (
    select * from {{ source('bronze', 'BRZ_POS_PEDIDO') }}
),
renamed as (
    select
        upper(trim(pos_id_pedido)) as pos_pedido_id,
        upper(trim(pos_id_cliente)) as pos_cliente_id,
        upper(trim(crm_id_contacto)) as crm_contacto_id,
        upper(trim(moneda)) as moneda,
        upper(trim(codigo_promocional)) as codigo_promocional,
        upper(trim(id_direccion_envio)) as direccion_envio_id,
        upper(trim(id_direccion_facturacion)) as direccion_facturacion_id,
        upper(trim(estado_pedido)) as estado_pedido,
        -- Números
        try_to_numeric(importe_subtotal, 38, 2) as importe_subtotal,
        try_to_numeric(importe_impuestos, 38, 2) as importe_impuestos,
        try_to_numeric(importe_total, 38, 2) as importe_total,
        -- Fechas
        try_to_timestamp(fecha_hora_pedido) as fecha_pedido_at
    from source
)
select * from renamed