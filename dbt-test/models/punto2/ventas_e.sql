SELECT a.cliente, pe.Precio
FROM {{ ref('compras') }} a INNER JOIN {{ ref('prices_e') }} pe ON  a.producto = pe.Codigo
