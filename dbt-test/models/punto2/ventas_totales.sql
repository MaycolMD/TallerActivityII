SELECT *
FROM {{ ref('ventas_e') }} 
UNION ALL
SELECT *
FROM {{ ref('ventas_o') }} 
