SELECT productos_.*, compras_.Cantidad_ as Frecuencia
FROM {{ ref('compras') }} compras_
INNER JOIN {{ ref('productos') }} productos_ ON compras_.producto = productos_.Codigo