# R Notes  

In this document I will include notes related to R and some functions and notes that I think are helpful for the problem solving and examples of the other pages. For example, I include an incomplete list of R packages the I have used for different examples and classes. In general R functions will not execute if they find a NA, they will stop without estimating the function, this can stop all the program, almost all the R functions have an option `na.rm = TRUE` that will instruct to not include the NA events, and dose events it will not be estimated and jump to the next command but will not stop the program.    

## Functions  
Some general R functions  
`sum(x)` addition of vector x.  
`mean(x)` mean estimation of numerical vector x (`sum(x)/lenght(x)`). R mean function has a `trim` option (.0, 0.5) to estimate the robust trimmed sample mean.  
`median(x)` median estimation of the numerical vector x.  
`mad(x)` median absolute deviation for the median of numerical vector x.  
`min(x)` y `max(x)` maximum and minimum of the numerical vector x.  
`sd(x)` y `var(x)` standard deviation and variance of the numerical vector x.  
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

## Important public resource  
There are "Cheatsheets" for several very useful libraries (tidyverse family) I recommend print them in color and keep them handy they are used very frequently. [Cheatsheets](https://www.rstudio.com/resources/cheatsheets/) from `tidy` family from Rstudio.    

## Tidy Data (as `dplyr`)  
First always load `tidyverse` using the `library()` command. There is a fundamental way of thinking using the "pipe" command `%>%` simplifying the way data is "passed to the functions in R in a "tidy" [tibbles way](https://es.r4ds.hadley.nz/tibbles.html) to find an intro of data handling in "tibbles".  The fundamental concept of a tibble and the relation of the variable, observation, and value the order is very important and for data structures and tibbles must follow:    
- Each **variable** is in its own **column**  
- Each **observation**, or case, is in its own **row**  
- Each **value** is in its **cell**    
  
  
Some, very few, commands for data transformation of data in "tibbles" this is "tidy data" from the `dplyr` cheatsheet (some verbs for data manipulation)    
- To select observations (rows) by their values    
 `filter()`  
- For row reordering  
 `arrange()`  
- To select variables (columns) by name  
 `select()`  
- To create a new variable (column) into an existing tibble  
 `mutate()`  
- All these functions can be used in combination with  
 `group_by()`  
These are very few functions and function complement commands for `dplyr`.  
 
## ggplot graphics  
For learning how to plot with ggplot I recommend, as introduction, to follow step by step chapter 4 of [Harrison & Pius](https://argoshare.is.ed.ac.uk/healthyr_bo,ok/), and for refreshing of the multiple commands to always have handy the `ggplot cheatsheet`, and always keep for the hunting of useful ggplot WEB  open resources like the [plotly](https://plotly.com/ggplot2/) page.  
 
## R (CRAN) packages  
Some (very few) [R packages](https://fabarrios.github.io/ProbEstad/Presenta/Libraries) are listed in the table, these are the more common libraries that I use in the examples presented in this ages. Remember to install always with the "install dependencies" option turned on!   
