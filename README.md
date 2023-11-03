# Análisis de Precios en el Mercado Local

El proyecto actual se centra en el análisis de variables de interés alrededor de dos marcas importantes en el mercado local. Hablamos de Éxito y Olímpica. Asimismo, se planea usar la información proporcionada para realizar consultas de valor relacionadas con este negocio. Todos los procesos y operaciones involucradas en este proyecto serán desarrolladas exclusivamente a través de Data Build Tool.

## Objetivo

El objetivo principal de este proyecto es analizar los precios de productos en las tiendas Olimpica y EXITO, responder a preguntas de negocio específicas y crear un panel de control en Looker Studio para visualizar los resultados.

## Instrucciones

### 1. Migración de Datos a BigQuery

Los siguientes conjuntos de datos se migrarán a BigQuery, provenientes de Google Drive, y se renombrarán como se indica:

- Compras_EXT
- Olimpica_EXT
- Exito_EXT
- Clientes_EXT

### 2. Creación de Tablas Materializadas en BigQuery

Se crearán tablas materializadas en BigQuery, utilizando la herramienta dbt para materializar todo el conjunto de datos mediante consultas. Las tablas materializadas se generarán a partir de las tablas traídas de Google Drive mencionadas anteriormente:

- Compras_EXT (vista) -> Compras (tabla)
- Olimpica_EXT (vista) -> Olimpica (tabla)
- Exito_EXT (vista) -> Exito (tabla)
- Clientes_EXT (vista) -> Clientes (tabla)

### 3. Imputación de Valores Faltantes

Se realizará la imputación de valores faltantes en los conjuntos de datos utilizando la mediana como estrategia. Los pasos para la imputación se describen a continuación.

#### 1. Una vez con las tablas materializadas, se comprueba una a una aquellas que contengan valores nulos en cualquiera de sus campos. Esto se hace mediante dbt, para comprobar qué tablas son necesarias imputar. 
#### 2. Al analizar la salida de dbt, se observa que únicamente la tabla Olímpica necesita imputación. 
#### 3. Luego, se realiza la imputación de los valores faltantes por la mediana. En este caso, habían 3 productos en la tabla Olímpica con Precio nulo. Se halló la mediana de todos los Precios de los productos y se imputó en los Precios faltantes. 

### 4. Respuestas a Preguntas

- Gasto Promedio: ¿Cuál es el gasto promedio en "Vino Tinto" en las tiendas Olimpica y EXITO?

Para calccular el gasto promedio de "Vino Tinto" se uso un código SQL que usa dos vistas temporales para extraer los códigos y precios de productos que contienen la cadena "Vino Tinto" de las tablas "Olimpica_IMP" y "Exito", respectivamente despues se crea una vista temporal que combina los resultados de las vistas "Vino_Tinto_OLI" y "Vino_Tinto_EXI" utilizando la operación "UNION ALL" dando como resultado un conjunto de datos que contiene todos los productos "Vino Tinto" con sus códigos y precios de ambas tiendas una vez hecho eso se crea una vista temporal que realiza un conteo de la cantidad de compras por producto en la tabla "Compras". Esto proporciona información sobre cuántas veces se ha comprado cada producto.

Se continua con la creacion de una vista temporal que realiza un JOIN entre las vistas "Vino_Tinto_PROD" y "Compras_AGG" utilizando el campo "producto". También calcula el total gastado en cada producto multiplicando la cantidad de compras por el precio. Además, determina el almacén ("Olimpica" o "EXITO") al que pertenece cada producto según el código, finalmente se realiza un cálculo del gasto promedio por almacén utilizando operaciones de ventana. Para cada fila en "Por_Almacen", se calcula el gasto promedio utilizando la función SUM(total) OVER (particion_almacen) para sumar el gasto total en productos en el mismo almacén y la función SUM(cantidad) OVER (particion_almacen) para sumar la cantidad total de compras en productos en el mismo almacén. Esto se hace en una partición definida por el almacén.


- Principales Compradores: ¿Quiénes son los compradores destacados en las tiendas Olimpica y EXITO?

Para responder esta pregunta se utilizo un código SQL el caul calcula el total de compras realizadas por cada cliente en las tiendas Olimpica y Exito, y presenta los resultados para los 20 principales clientes con las compras más altas. 

Se inicia con una consulta llamada "Prices" que combina los datos de precios de los productos de las tiendas Olimpica y Exito en una sola tabla. Esto se logra utilizando la cláusula UNION ALL.

Luego, se crea otra consualta llamada "Ventas" que se utiliza para unir los datos de compras de los clientes con los datos de precios de los productos. La unión se realiza mediante la coincidencia de los códigos de productos en las compras con los códigos de productos en la tabla "Prices". Esto proporciona información sobre el precio de compra de cada producto.

Finalmente, se realiza la consulta principal. Calcula la suma total de compras ("SUM(v.Precio)") para cada cliente ("v.cliente") en la CTE "Ventas". Luego, los resultados se agrupan por cliente utilizando la cláusula "GROUP BY". El resultado muestra el total de compras para cada cliente y se ordena en orden descendente ("ORDER BY Compras_Totales DESC") para identificar a los 20 principales clientes con las compras más altas.

- Clientes Únicos de Olimpica: ¿Quiénes son los clientes que han realizado compras específicamente en Olimpica pero no en EXITO?
- Productos Populares: ¿Cuáles son los productos principales que las personas compran con frecuencia?
- Artículos no Comprados: ¿Qué artículos nunca han sido comprados por los clientes?

Se construirá un panel de control en Looker Studio para visualizar los resultados de cada una de las preguntas.

## Requisitos

Para ejecutar correctamente este proyecto, necesitas seguir los siguientes pasos:
