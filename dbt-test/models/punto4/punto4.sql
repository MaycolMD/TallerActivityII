SELECT *
FROM {{ ref('cruceInformacion') }}
ORDER BY Frecuencia DESC
LIMIT 10