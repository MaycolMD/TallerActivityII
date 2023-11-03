SELECT a.cliente,po.Precio
FROM {{ ref('compras') }} a INNER JOIN {{ ref('prices_o') }} po ON a.producto = po.Codigo
