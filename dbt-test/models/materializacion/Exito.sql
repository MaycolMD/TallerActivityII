{{ config (materialized = "table") }}
SELECT * FROM {{ source('Supermarket', 'Exito_EXT') }}