SELECT a.cliente, pe.Precio
FROM {{ ref('comprasTotales') }} a INNER JOIN {{ ref('preciosExito') }} pe ON  a.producto = pe.Codigo
