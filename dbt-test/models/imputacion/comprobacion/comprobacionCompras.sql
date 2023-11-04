SELECT *
FROM {{ ref('Compras') }}
WHERE cliente IS NULL
   OR producto IS NULL
   OR fecha IS NULL