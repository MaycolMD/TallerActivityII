{{ config (materialized = "table") }}
SELECT productos_.*, IFNULL(Cantidad_, 0) AS Cantidad_Compras
FROM {{ ref('productos') }} productos_
LEFT JOIN {{ ref('compras') }} compras_ ON productos_.Codigo = compras_.producto 
WHERE compras_.producto is null