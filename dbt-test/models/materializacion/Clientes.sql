{{ config (materialized = "table") }}
SELECT * FROM {{ source('Supermarket', 'Clientes_EXT') }}