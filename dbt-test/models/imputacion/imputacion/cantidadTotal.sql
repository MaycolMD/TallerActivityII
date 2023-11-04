SELECT Precio, COUNT(*) OVER() AS cantidad
FROM {{ ref('Olimpica') }}
WHERE Precio IS NOT NULL
ORDER BY Precio