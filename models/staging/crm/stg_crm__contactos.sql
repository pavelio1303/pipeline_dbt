with source as (
    select * from {{ source('bronze', 'BRZ_CRM_CONTACTO') }}
),
renamed as (
    select
        upper(trim(crm_id_contacto)) as crm_contacto_id,
        upper(trim(correo)) as email,
        upper(trim(telefono)) as telefono,
        upper(trim(nombre)) as nombre,
        upper(trim(apellidos)) as apellidos,
        upper(trim(pais)) as pais,
        upper(trim(ciudad)) as ciudad,
        -- Conversiones de fecha
        try_to_timestamp(fecha_hora_alta) as fecha_alta_at,
        try_to_date(fecha_nacimiento) as fecha_nacimiento_date
    from source
)
select * from renamed