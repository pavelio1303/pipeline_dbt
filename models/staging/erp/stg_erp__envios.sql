{{
  config(
    materialized='incremental',
    unique_key='envio_id',
    incremental_strategy='merge'
  )
}}

with source as (
    select * from {{ source('bronze', 'BRZ_ERP_ENVIO') }}

    {% if is_incremental() %}
      -- Filtro incremental para comparar origen vs destino
      where try_to_timestamp(fecha_hora_envio) > (select max(enviado_at) from {{ this }})
    {% endif %}
),

renamed_cleaned as (
    select
        upper(trim(erp_id_envio)) as envio_id,
        upper(trim(erp_id_pedido)) as erp_pedido_id,
        upper(trim(transportista)) as transportista,
        upper(trim(numero_seguimiento)) as tracking_nro,
        upper(trim(pais_destino)) as pais_destino,
        upper(trim(estado_envio)) as estado_envio,

        try_to_timestamp(fecha_hora_envio) as enviado_at

    from source
)

select * from renamed_cleaned