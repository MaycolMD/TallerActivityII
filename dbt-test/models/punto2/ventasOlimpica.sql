SELECT a.cliente,po.Precio
FROM {{ ref('comprasTotales') }} a INNER JOIN {{ ref('preciosOlimpica') }} po ON a.producto = po.Codigo
