{{ config (materialized = "table") }}
SELECT * FROM {{ source('Supermarket', 'Olimpica_EXT') }}