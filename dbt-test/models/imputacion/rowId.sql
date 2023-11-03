SELECT *, ROW_NUMBER() OVER () AS row_id
FROM {{ ref('cantidadTotal') }}