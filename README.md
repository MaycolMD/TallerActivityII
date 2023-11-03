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

# Preguntas

## 1. Gasto Promedio: ¿Cuál es el gasto promedio en "Vino Tinto" en las tiendas Olimpica y EXITO?
## 2. Principales Compradores: ¿Quiénes son los compradores destacados en las tiendas Olimpica y EXITO?
## 3. Clientes Únicos de Olimpica: ¿Quiénes son los clientes que han realizado compras específicamente en Olimpica pero no en EXITO?
## 4. Productos Populares: ¿Cuáles son los productos principales que las personas compran con frecuencia?
## 5. Artículos no Comprados: ¿Qué artículos nunca han sido comprados por los clientes?

Para abordar esta pregunta, se comprendió primero que nada los artículos nunca comprados por los clientes como aquellos productos con 0 apariciones en la tabla Compras, que conforman el histórico de compras de los almacenes.
Es por esto que para el desarrollo de la pregunta: 
#### 1. Primero, se obtuvieron las compras totales agrupadas por Producto, con una columna nueva llamada 'Cantidad', que almacena la cuenta de cada una de las apariciones de ese producto en la tabla Compras. Donde se obtuvo algo así:
  ![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/2df2e53a-4df3-427b-8678-b2a701492ace)

#### 2. Por otro lado, se obtuvieron los productos asociados a Éxito, con toda su información. Asimismo, los productos asociados a Olímpica. Ambas tablas se unieron en una sola llamada Productos. 
#### 3. Finalmente, se hizo un LEFT JOIN de la tabla Productos con la tabla Compras, para obtener los productos con sus respectivas compras, de esta forma:
![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/be3e36d9-9ffd-453d-8bba-f0a0d0cebc1a)
#### 4. Al ser únicamente los productos que no estuvieran en ambas tablas (es decir, los no comprados), se filtró la imagen anterior a aquellos productos que aparecieran únicamente en la tabla Productos y no en la tabla Compras. En palabras sencillas, aquellos productos que no están en el registro de Compras. 
![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/e0e3c0e2-561a-46b7-afb2-631f4548c2e6)

## 6 Looker Studio
Se construirá un panel de control en Looker Studio para visualizar los resultados de cada una de las preguntas.

## Requisitos

Para ejecutar correctamente este proyecto, necesitas seguir los siguientes pasos:
