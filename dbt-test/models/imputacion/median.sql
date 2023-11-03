SELECT
CASE
WHEN MOD(cantidad, 2)=0 THEN (SELECT AVG(Precio) FROM {{ ref('rowId') }} WHERE row_id BETWEEN cantidad/2 AND cantidad/2+1)
ELSE (SELECT Precio FROM {{ ref('rowId') }} WHERE row_id=ROUND(cantidad/2))
END median_
FROM {{ ref('rowId') }}
LIMIT 1