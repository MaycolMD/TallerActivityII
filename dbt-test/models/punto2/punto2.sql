SELECT vt.cliente, SUM(vt.Precio) as Compras_Totales
FROM {{ ref('ventas_totales') }}  vt 
GROUP BY vt.cliente
ORDER BY Compras_Totales DESC
LIMIT 20