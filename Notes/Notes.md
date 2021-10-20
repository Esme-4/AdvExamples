# R Notes  

In this document I will include notes related to R and some functions and notes that I think are helpful for the probelm solving and examples of the other pages. For example I include an incomplete list of R packages the I have used for different examples and classes. For example in general R fucntions will not excecute if they find a NA and stop without estimating the function, this can stop all the program, almost all the R functions have an option `na,rm = TRUE` will not include the NA events nevertheless it will not estimate and juno to the next command but will stop the program.    

## Functions  
Some general R functions  
`sum(x)` addition of vector x.  
`mean(x)` mean estimation of numerical vector  x (`sum(x)/lenght(x)`). It has a `trim` option (0., 0.5) to estimate the robust trimmed smaple mean.  
`median(x)` median estimation of the numerical vector x.  
`mad(x)` median absolute deviation for the median of numerical vector x.  
`min(x)` y `max(x)` maximum and minimun of the numerical vector x.  
`sd(x)` y `var(x)` stadndar deviation and variance of the numerical vector x.  
`IQR(x)` Inter Quartile Range, uses function `quantile(x)`.   

## Logical filter operators  

| Operators | Meaning |  
| :-------: | ------- |  
|  ==  |  equal to  |  
|  !=  |  not equal to  |  
|  <  | less than  |  
|  >  |  greater than  |  
|  <=  |  less than or equal to  |
|  >=  |  greater than or equal to  |
|  &  |  AND  |  
|  \| |  OR  |  

## Importatn resource  
There are "Cheatsheets" for several very useful libraries (tidyverse familly) I recomned print them in color and keep them handy they are used very frequently. [Cheatsheets](https://www.rstudio.com/resources/cheatsheets/) from `tidy` familly from Rstudio.    

## Tidy Data (de acuerdo a `dplyr`)  
Para hacer uso de estos comandos hay que cargar la `tidyverse` por medio del comando `library()`. Estos comandos son usados frecuentemente con el comando de "tubería o tubo" `%>%` y son de extrema utilidad al manipular estructuras de datos, o tablas o cómo se llaman en los datos "tidy" tibbles (tablas) en esta [liga](https://es.r4ds.hadley.nz/tibbles.html) se encuentra un documento que explica en R el manejo de "tibbles".  
Aquí se lista algunos comandos básicos (muy básicos) y conceptoe fundamentales del orden que debe seguir una tabla de tados o tibble:  
- Cada variable está en una columna  
- Cada observación es un renglón  
- Cada valor es la celda  
  
  
Algunos (pocos) comandos para transformación de datos en "tidy data" de `dplyr` (vervos de manipulación de datos)    
- Para escojer observaciones por sus valores  
 `filter()`  
- Para reordenar renglones  
 `arrange()`  
- Para seleccionar variables por nombre  
 `select()`  
- Para creas una variable (columna) nueva en una tibble existente  
 `mutate()`  
- Todas se pueden usar junto con  
 `group_by()`  
Estos son solo algunas funciones y comentarios para recordar el uso de algunos comandos de `dplyr`.  
 
## Gráficas con ggplot  
 Para gráficas en `ggplot` ademas del libro de [Harrison & Pius](https://argoshare.is.ed.ac.uk/healthyr_book/), hay varias páginas en la red que tienen recursos para aprender a hacer gráficas en ggplot una buena es [plotly](https://plotly.com/ggplot2/)  
 
## Librerías de R (CRAN)  
Algunas [librerías de R](https://fabarrios.github.io/ProbEstad/Presenta/Libraries) estan latabla, pero al instalar se instalan varias otras librerías que complementan la operación del conjunto. Siempre es bueno checar por compatibilidades de las librerías cargadas en memoria.  

