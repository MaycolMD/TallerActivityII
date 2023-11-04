SELECT *
FROM {{ ref('Exito') }}
WHERE Codigo IS NULL
   OR Producto IS NULL
   OR Cantidad IS NULL
   OR Unidad IS NULL
   OR Precio IS NULL
