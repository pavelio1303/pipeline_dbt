with source as (
    select * from {{ source('bronze', 'BRZ_POS_PAGO') }}
),
renamed as (
    select
        upper(trim(pos_id_pago)) as pago_id,
        upper(trim(pos_id_pedido)) as pos_pedido_id,
        upper(trim(proveedor_pago)) as proveedor_pago,
        upper(trim(metodo_pago)) as metodo_pago,
        upper(trim(estado_pago)) as estado_pago,
        upper(trim(moneda)) as moneda,
        -- Importe y Fecha
        try_to_numeric(importe_pago, 38, 2) as importe_pago,
        try_to_timestamp(fecha_hora_pago) as pagado_at
    from source
)
select * from renamed