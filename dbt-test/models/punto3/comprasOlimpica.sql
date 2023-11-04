SELECT 
cliente,
producto
FROM {{ ref('Compras') }}
WHERE producto LIKE "OLI%"
GROUP BY cliente, producto