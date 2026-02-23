with source as (
    select * from {{ source('bronze', 'BRZ_ERP_ARTICULO') }}
),
renamed as (
    select
        upper(trim(erp_id_articulo)) as erp_articulo_id,
        upper(trim(sku)) as sku,
        upper(trim(nombre_articulo)) as nombre_articulo,
        upper(trim(marca)) as marca,
        upper(trim(unidad_medida)) as unidad_medida,
        -- Booleano S/N
        case 
            when upper(trim(activo)) = 'S' then True 
            when upper(trim(activo)) = 'N' then False 
            else null 
        end as is_activo,
        -- Numérico coerce
        try_to_numeric(coste_estandar, 38, 2) as coste_estandar,
        try_to_timestamp(fecha_hora_alta) as fecha_alta_at
    from source
)
select * from renamed