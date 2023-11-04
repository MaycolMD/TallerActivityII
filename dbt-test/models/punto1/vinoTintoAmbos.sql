SELECT *
FROM {{ ref('vinoTintoOli') }}

UNION ALL

SELECT *
FROM {{ ref('vinoTintoExi') }}