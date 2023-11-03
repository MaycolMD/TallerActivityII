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
- Principales Compradores: ¿Quiénes son los compradores destacados en las tiendas Olimpica y EXITO?
- Clientes Únicos de Olimpica: ¿Quiénes son los clientes que han realizado compras específicamente en Olimpica pero no en EXITO?
- Productos Populares: ¿Cuáles son los productos principales que las personas compran con frecuencia?
- Artículos no Comprados: ¿Qué artículos nunca han sido comprados por los clientes?

Se construirá un panel de control en Looker Studio para visualizar los resultados de cada una de las preguntas.

## Requisitos

Para ejecutar correctamente este proyecto, necesitas seguir los siguientes pasos:
