SELECT *,
(SUM(total) OVER (particion_almacen)) / (SUM(cantidad) OVER (particion_almacen)) promedio_almacen
FROM {{ ref('cruceProductos') }}
WINDOW particion_almacen AS (
  PARTITION BY almacen
)