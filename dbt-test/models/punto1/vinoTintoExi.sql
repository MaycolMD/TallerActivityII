SELECT Codigo, Precio
FROM {{ ref('Exito') }}
WHERE Producto LIKE '%Vino Tinto%'