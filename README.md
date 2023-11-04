# Búsqueda rápida
[Preprocesamiento](#preprocesamiento)

[Preguntas](#preguntas)

[Looker Studio](#6-looker-studio)

[Ejecución Proyecto](#ejecución-del-proyecto)

# Análisis de Precios en el Mercado Local

El proyecto actual se centra en el análisis de variables de interés alrededor de dos marcas importantes en el mercado local. Hablamos de Éxito y Olímpica. Asimismo, se planea usar la información proporcionada para realizar consultas de valor relacionadas con este negocio. Todos los procesos y operaciones involucradas en este proyecto serán desarrolladas exclusivamente a través de Data Build Tool.

## Objetivo

El objetivo principal de este proyecto es analizar los precios de productos en las tiendas Olimpica y EXITO, responder a preguntas de negocio específicas y crear un panel de control en Looker Studio para visualizar los resultados.

## Preprocesamiento

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

Para abordar esta pregunta, se llevó a cabo un proceso de análisis que involucró varias etapas clave:

Filtrado de Productos de 'Vino Tinto' en Olimpica y Éxito:

En primer lugar, teniendo los dos conjuntos de datos separados, uno la de tienda "Olimpica" y otro de la tienda "Éxito", con la infromacion sobre los productos. Se crearon dos nuevos conjuntos denominados "vinoTintoOli" y "vinoTintoExi", que contenían la informacion de los vinos tintos de cada tienda respectivamente.

Consolidación de Productos de 'Vino Tinto':

Posteriormente, los productos de "Vino Tinto" de ambas tiendas se unieron en una única tabla llamada "VinoTintoAmbos". Esta tabla contenía la información de productos de "Vino Tinto" tanto de Olimpica como de Éxito.

Calcular promedio del gasto del 'Vino Tinto':

Para poder saber el promedio del gasto se tiene que conocer el gasto total, se cruzó la cantidad de Vino Tinto comprado, es decir la información que está en "VinoTintoAmbos", con el precio y las compras hechas, información que se encontraba en la tabla "compras" y una vez con eso se calculó el promedio del gasto en el Vino Tinto.

Finalmente promedio por almacén:

Ya con toda la información obtenida se agruparon los datos por almacén respondiendo la pregunta de cuál es el gasto promedio de Vino Tinto por cada uno.

## 2. Principales Compradores: ¿Quiénes son los compradores destacados en las tiendas Olimpica y EXITO?

Para abordar esta pregunta y identificar a los compradores destacados en las tiendas Olimpica y Éxito, se siguió un proceso analítico que involucró las siguientes etapas clave:

Obtención de Precios de Productos en Olimpica y Éxito:

En primer lugar, partiendo de dos conjuntos de datos separados, uno para la tienda "Olimpica" y otro para "Éxito". De estos conjuntos se extrajeron dos muevos, denominados "preciosOlimpica" y "preciosExito" respectivamente, que contenían información sobre los códigos y precios de los productos disponibles en cada una de las tiendas.

Asociación de Precios con Compras:

Luego, se analizaron las compras de los clientes en la tabla "Compras". Se crearon dos tablas separadas, "ventasOlimpica" y "ventasExito", que contenían información sobre los clientes y los precios asociados a sus compras en Olimpica y Éxito. Esto se logró mediante la combinación de la tabla de compras con las tablas de precios correspondientes.

Consolidación de Compras de Ambas Tiendas:

Se creó una tabla llamada "ventasTotales" que combinó las compras de ambas tiendas (Olimpica y Éxito). Esta tabla contenía información de todas las compras realizadas en ambas tiendas y se utilizó para identificar a los compradores destacados sin importar la tienda en la que realizaron sus compras.

Cálculo de Compras Totales por Cliente:

Se realizó un cálculo del gasto total de cada cliente en todas sus compras, independientemente de la tienda. Esto se hizo mediante la suma de los valores de compra en la tabla "ventasTotales" para cada cliente.

Identificación de los 10 Compradores Destacados:

Finalmente, se seleccionaron los 10 compradores que realizaron las compras más destacadas, es decir, los que presentaron el gasto total más alto en todas sus compras. Estos compradores se identificaron y se presentaron en orden descendente de acuerdo con sus gastos totales, esto para que este de primero aquel comprador que más compras hizo.

## 3. Clientes Únicos de Olimpica: ¿Quiénes son los clientes que han realizado compras específicamente en Olimpica pero no en EXITO?

Para poder responder esta pregunta, aplicamos la lógica moldeada por la misma. Necesitamos obtener los clientes que SÍ han realizado compras en Olímpica Y NO han realizado compras en Éxito. De forma más específica, necesitamos obtener los códigos de estos clientes, filtrando con las condiciones antes mencionadas.
#### 1. El primer paso fue distinguir los códigos de productos pertenecientes a Olímpica y los pertenecientes a Éxito.
En la tabla de Compras pudimos observar que los códigos siguen una regla sencilla. Los códigos que empiezan por 'OLI' pertenecen a productos de Olímpica, mientras que los códigos que comienzan por 'EXI' son pertenecientes a productos de Éxito.

![image](https://github.com/MaycolMD/TallerActivityII/assets/67843249/678379f7-4c5a-42d8-b660-c0b12c033624)


#### 2. Luego, aplicamos la condición.
Primero seleccionamos todos los registros con códigos de producto pertenecientes a Olímpica de la forma antes mencionada. Enseguida aplicamos la condición de excluir los registros de clientes que, además de Olímpica, contengan compras de Éxito.

#### 3. Por último, seleccionamos los códigos de clientes únicos.

#### El resultado de esta consulta es que no hay tales clientes en nuestros datos. Todos los clientes que han comprado en Olímpica también han comprado en Éxito.

## 4. Productos Populares: ¿Cuáles son los productos principales que las personas compran con frecuencia?

En esta consulta se nos pide obtener los productos que se venden más frecuentemente, por lo que necesitamos obtener la información de los productos (sus códigos) y los datos de las compras. Para ello, el proceso fue el siguiente:

#### 1. Seleccionamos la columna 'producto' de la tabla 'Compras'.

![image](https://github.com/MaycolMD/TallerActivityII/assets/67843249/8625825c-15b0-42e2-bf00-f30191f80594)


#### 2. Agrupamos por producto y contamos las veces que aparece cada código del mismo.
Esto se puede hacer porque en la tabla de 'Compras' cada registro pertenece a la venta de una unidad del producto, por lo que al sumar sus registros obtenemos la cantidad vendida.


## 5. Artículos no Comprados: ¿Qué artículos nunca han sido comprados por los clientes?

Para abordar esta pregunta, se comprendió primero que nada los artículos nunca comprados por los clientes como aquellos productos con 0 apariciones en la tabla Compras, que conforman el histórico de compras de los almacenes.
Es por esto que para el desarrollo de la pregunta: 
#### 1. Primero, se obtuvieron las compras totales agrupadas por Producto, con una columna nueva llamada 'Cantidad', que almacena la cuenta de cada una de las apariciones de ese producto en la tabla Compras. Donde se obtuvo algo así:
![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/2492cba9-18f4-423b-8e8b-5c67096cd540)



#### 2. Por otro lado, se obtuvieron los productos asociados a Éxito, con toda su información. Asimismo, los productos asociados a Olímpica. Ambas tablas se unieron en una sola llamada Productos. 
#### 3. Finalmente, se hizo un LEFT JOIN de la tabla Productos con la tabla Compras, para obtener los productos con sus respectivas compras, de esta forma:
![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/e6be2f60-b563-4142-803b-4ee729bb2c90)

#### 4. Al ser únicamente los productos que no estuvieran en ambas tablas (es decir, los no comprados), se filtró la imagen anterior a aquellos productos que aparecieran únicamente en la tabla Productos y no en la tabla Compras. En palabras sencillas, aquellos productos que no están en el registro de Compras. 
![image](https://github.com/MaycolMD/TallerActivityII/assets/68664300/6d6ea67a-d52f-4026-9554-fe2dc598ced6)

## 6. Looker Studio
Se construirá un panel de control en Looker Studio para visualizar los resultados de cada una de las preguntas. El panel desarrollado es el siguiente:

[Looker Studio Dashboard](https://lookerstudio.google.com/reporting/cce78af2-759f-4a20-8951-1cb1a39a563a)


## Ejecución del Proyecto

Para ejecutar correctamente este proyecto, necesitas seguir los siguientes pasos:

### 1. Descargar el repositorio, descomprimirlo y ubicarlo en alguna carpeta, o traerlo directamente desde GitHub haciendo un clone con:
```bash
    git clone https://github.com/MaycolMD/TallerActivityII.git
```

### 2. Ubicado en la carpeta, crea el entorno virtual
```bash
    python -m venv venv
```

### 3. Una vez creado el entorno, accede a él.
para Windows
```bash
    venv\Scripts\activate
```
para MacOS y Linux
```bash
    source venv/bin/activate
```

### 4. Una vez en el entorno virtual, nos dirigimos a la carpeta donde se encuentra el proyecto dbt.
```bash
    cd dbt-test
```

### 5. Ahora, instalamos las dependencias necesarias
```bash
    pip install dbt-core dbt-bigquery
```

### Finalmente, dependiendo de lo que queramos hacer, ejecutamos el comando respectivo
para ejecutar un test del proyecto dbt:
```bash
    dbt test
```
para ejecutar completamente el dbt con todos sus modelos:
```bash
    dbt run
```
para ejecutar únicamente la carpeta deseada:
```bash
    dbt run -m nombreCarpeta
```

Para ver la documentación del proyecto más detallada,

Para generarla
```bash
    dbt docs generate
```
Para mostrarla
```bash
    dbt docs serve
```
