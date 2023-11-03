SELECT 
producto, COUNT(*) AS Cantidad_
FROM {{ ref('Compras') }}
group by producto