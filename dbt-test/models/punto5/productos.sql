SELECT *
FROM {{ ref('productosOlimpica') }}

UNION ALL

SELECT *
FROM {{ ref('productosExito') }}