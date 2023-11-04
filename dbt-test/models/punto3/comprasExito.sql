SELECT 
cliente,
producto
FROM {{ ref('Compras') }}
WHERE producto LIKE "EXI%"
GROUP BY cliente, producto