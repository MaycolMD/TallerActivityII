SELECT *
FROM {{ ref('ventasExito') }} 
UNION ALL
SELECT *
FROM {{ ref('ventasOlimpica') }} 
