SELECT IF(SUBSTR(vino_tinto_.Codigo,1,3)='OLI', 'Olimpica', 'EXITO') AS almacen,
vino_tinto_.Codigo AS producto, 
compras_.Cantidad_ AS cantidad,
compras_.Cantidad_ * vino_tinto_.Precio AS total
FROM {{ ref('compras') }} compras_ INNER JOIN {{ ref('vinoTintoAmbos') }} vino_tinto_ ON compras_.producto = vino_tinto_.Codigo