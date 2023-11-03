WITH Prices_O AS (
  SELECT Codigo,Precio
  FROM {{ ref('Olimpica_IMP') }}
),
Prices_E AS (
  SELECT Codigo,Precio
  FROM {{ ref('Exito') }}
),
Ventas_O AS (
  SELECT a.cliente,po.Precio
  FROM {{ ref('Compras') }} a INNER JOIN Prices_O po ON a.producto = po.Codigo
),
Ventas_E AS (
  SELECT a.cliente, pe.Precio
  FROM {{ ref('Compras') }} a INNER JOIN Prices_E pe ON  a.producto = pe.Codigo
),
Ventas_totales AS (
  SELECT *
  FROM Ventas_E

  UNION ALL

  SELECT *
  FROM Ventas_O
)

SELECT vt.cliente, SUM(vt.Precio) as Compras_Totales
FROM Ventas_totales vt 
GROUP BY vt.cliente
ORDER BY Compras_Totales DESC
LIMIT 20