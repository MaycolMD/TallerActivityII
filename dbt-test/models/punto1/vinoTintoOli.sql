SELECT Codigo, Precio
FROM {{ ref('Olimpica_IMP') }}
WHERE Producto LIKE '%Vino Tinto%'