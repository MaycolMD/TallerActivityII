SELECT *
FROM {{ ref('Clientes') }}
WHERE C__digo IS NULL
   OR Apellido IS NULL
   OR Nombre IS NULL
   OR Email IS NULL
   OR Celular IS NULL
   OR Edad IS NULL
   OR Latitud IS NULL
   OR Longitud IS NULL