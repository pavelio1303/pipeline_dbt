with source as (
    select * from {{ source('bronze', 'BRZ_CRM_CONSENTIMIENTO') }}
),
renamed as (
    select
        upper(trim(crm_id_contacto)) as crm_contacto_id,
        upper(trim(tipo_consentimiento)) as tipo_consentimiento,
        -- Mapeo booleano S/N
        case 
            when upper(trim(consiente)) = 'S' then True 
            when upper(trim(consiente)) = 'N' then False 
            else null 
        end as is_consiente,
        upper(trim(sistema_origen)) as sistema_origen,
        try_to_timestamp(fecha_hora_registro) as registrado_at
    from source
)
select * from renamed