SELECT * EXCEPT(Precio, median_), IFNULL(Precio, median_) AS Precio
FROM {{ ref('Olimpica') }}, {{ ref('median') }}