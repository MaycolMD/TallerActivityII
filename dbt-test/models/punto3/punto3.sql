SELECT olimpica_.*
FROM {{ ref('comprasOlimpica') }} olimpica_
LEFT JOIN {{ ref('comprasExito') }} exito_ ON olimpica_.cliente = exito_.cliente
WHERE exito_.cliente IS NULL