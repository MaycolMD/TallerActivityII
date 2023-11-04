SELECT almacen, promedio_almacen
FROM {{ ref('promedio') }}
GROUP BY almacen, promedio_almacen