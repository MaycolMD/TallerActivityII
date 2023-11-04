{{ config (materialized = "table") }}
SELECT c.C__digo,CONCAT(c.Nombre, ' ', c.Apellido) as Nombre, c.Celular, c.Edad, SUM(vt.Precio) as Compras_Totales
FROM {{ ref('ventasTotales') }}  vt 
INNER JOIN {{ ref('Clientes') }} c ON vt.cliente = c.C__digo
GROUP BY c.C__digo, c.Nombre, c.Apellido, c.Celular, c.Edad
ORDER BY Compras_Totales DESC
LIMIT 10