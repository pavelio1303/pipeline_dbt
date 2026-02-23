with source as (
    select * from {{ source('bronze', 'BRZ_ERP_PEDIDO') }}
),
renamed as (
    select
        upper(trim(erp_id_pedido)) as erp_pedido_id,
        upper(trim(pos_id_pedido)) as pos_pedido_id,
        upper(trim(erp_id_cuenta_cliente)) as erp_cuenta_cliente_id,
        upper(trim(estado_preparacion)) as estado_preparacion,
        upper(trim(moneda)) as moneda,
        upper(trim(id_almacen)) as almacen_id,
        upper(trim(erp_id_factura)) as erp_factura_id,
        -- Numérico y Fechas
        try_to_numeric(importe_total, 38, 2) as importe_total_erp,
        try_to_timestamp(fecha_hora_alta_erp) as fecha_alta_erp_at
    from source
)
select * from renamed