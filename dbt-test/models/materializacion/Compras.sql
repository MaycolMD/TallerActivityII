{{ config (materialized = "table") }}
SELECT * FROM {{ source('Supermarket', 'Compras_EXT') }}