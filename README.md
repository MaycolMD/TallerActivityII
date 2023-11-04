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
Para calcular el gasto promedio de "Vino Tinto" se uso un código SQL que usa dos tablas temporales para extraer los códigos y precios de productos que contienen la cadena "Vino Tinto" de las tablas "Olimpica_IMP" y "Exito", respectivamente. Después, se crea una tabla temporal que combina los resultados de las tablas "vinoTintoOli" y "vinoTintoExi", utilizando la operación "UNION ALL" dando como resultado un conjunto de datos que contiene todos los productos "Vino Tinto", con sus códigos y precios de ambas tiendas. Una vez hecho eso, se crea una tabla temporal que realiza un conteo de la cantidad de compras por producto en la tabla "Compras". Esto proporciona información sobre cuántas veces se ha comprado cada producto.

Se continúa con la creación de una tabla temporal que realiza un JOIN entre las tablas "vinoTintoAmbas" y "compras", utilizando el identificador primario del Producto, el cual es apuntado por la llave foránea de Compras (producto y Codigo, respectivamente). También calcula el total gastado en cada producto multiplicando la cantidad de compras por el precio. Además, determina el almacén ("Olimpica" o "EXITO") al que pertenece cada producto según el código, finalmente se realiza un cálculo del gasto promedio por almacén utilizando operaciones de ventana. Para cada fila en "promedio", se calcula el gasto promedio utilizando la función SUM(total) OVER (particion_almacen) para sumar el gasto total en productos en el mismo almacén y la función SUM(cantidad) OVER (particion_almacen) para sumar la cantidad total de compras en productos en el mismo almacén. Esto se hace en una partición definida por el almacén.

## 2. Principales Compradores: ¿Quiénes son los compradores destacados en las tiendas Olimpica y EXITO?

Para responder esta pregunta se utilizo un código SQL el caul calcula el total de compras realizadas por cada cliente en las tiendas Olimpica y Exito, y presenta los resultados para los 20 principales clientes con las compras más altas. 

Se inicia con una consulta llamada "Prices" que combina los datos de precios de los productos de las tiendas Olimpica y Exito en una sola tabla. Esto se logra utilizando la cláusula UNION ALL.

Luego, se crea otra consualta llamada "Ventas" que se utiliza para unir los datos de compras de los clientes con los datos de precios de los productos. La unión se realiza mediante la coincidencia de los códigos de productos en las compras con los códigos de productos en la tabla "Prices". Esto proporciona información sobre el precio de compra de cada producto.

Finalmente, se realiza la consulta principal. Calcula la suma total de compras ("SUM(v.Precio)") para cada cliente ("v.cliente") en la CTE "Ventas". Luego, los resultados se agrupan por cliente utilizando la cláusula "GROUP BY". El resultado muestra el total de compras para cada cliente y se ordena en orden descendente ("ORDER BY Compras_Totales DESC") para identificar a los 20 principales clientes con las compras más altas.

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
