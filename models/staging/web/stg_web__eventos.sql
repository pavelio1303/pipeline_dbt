with source as (
    select * from {{ source('bronze', 'BRZ_WEB_EVENTO') }}
),
renamed as (
    select
        upper(trim(id_evento)) as evento_id,
        upper(trim(id_sesion)) as sesion_id,
        upper(trim(web_id_usuario)) as web_usuario_id,
        upper(trim(tipo_evento)) as tipo_evento,
        upper(trim(sku)) as sku,
        upper(trim(pos_id_pedido)) as pos_pedido_id,
        try_to_timestamp(fecha_hora_evento) as evento_at
    from source
)
select * from renamed