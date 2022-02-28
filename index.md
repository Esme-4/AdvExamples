# Statistical examples and solved problems  
## Fernando A. Barrios, Ph.D.  
## Universidad Nacional Autónoma de México, Instituto de Neurobiología  
#### contact: barrios@inb.unam.mx  

## Introduction  
These pages contain some data manipulations and solved problems ilustrating advanced statistics examples, many problems are taken from the Daniel's Biostatistics 
book. All the examples are solved using R ([CRAN](https://cran.r-project.org/)) and different R packages, running over 
[RStudio](https://rstudio.com/products/rstudio/), the idea is to use this site as support of the different statistics courses I teach at UNAM. There is an undergraduate [statistics course](https://fabarrios.github.io/ProbEstad/) with its related material in the WEB.  I also have some [notes](https://fabarrios.github.io/AdvExamples/Notes/Notes). For the problems presented here I started with some t-Test, ANOVA, and regression examples.  

## Student's *t* Test, Comparing Two Samples     
The simplest so-called classical tests for comparing two samples means, for independent samples, with constant variances of the samples, and errors normally distributed the *Student's t test* can be used, and when the samples are independent but the errors are not normally distributed the *Wilcoxon rank-sum test*. We have some examples for the comparison of the means of two examples. We also include paired comparison of two samples a method employed for assessing the effectiveness of an experimental procedure that makes use of related observations resulting from nonindependent samples, where we use the paired measures t-Test. In the [following examples](https://fabarrios.github.io/AdvExamples/t_testExamples/t_testExamples.html) we include some examples of t tests and paired comparisons using R.  

## OneWay ANOVA  
After loading data in R, the first step is to understand the format and structure of the data loaded, and restructure its order if needed to use the 
different R functions and the needed libraries, for the statistica test and *post hoc* analysis. For ANOVA examples the first examples are from some large data sets (LDS) from the end of chapter 8 of Daniel's book. For the first example of one-way ANOVA the data when loaded is in "table" format and it is necesary to change to long format, data wrangling is the term used to describe the handling of the data to set it in a format needed for the R functions to solve the problem properly. Then the ANOVA model is solved using different R functions, of the [serum lipid-bound sialic acid (LSA) data problem](https://fabarrios.github.io/AdvExamples/LSAdataWrangling.html).

## Repeated Measures Design
A prepeated measures design in one in which measures of the same variable are made on each bubject on two or more diferent ocassions. The mayor advantage of this kind of design is the ability to control for extraneous variables among subjects. Other advantage is the need fo less subjects. Nevertheless, there are potential problems as the carry-over effect, in which different conditions most be known to return to baseline before the next condition is measured. In [these pages there are some examples](https://fabarrios.github.io/AdvExamples/RepeatOneWay_02.html) solved in R. 

## Bibliography  
1. Daniel, W.W. (2009) Biostatistics. A Foundation for Analysis in the Health Sciences, Wiley, 9th Edition.  
2. Harrell, F.E. (2015) Regression Modeling Strategies (2nd edition), Springer Series in Statistics, Springer.  
3. Hothorn, T. & Everitt, B.S. (2014) A Handbook of Statistical Analyses Using R (3rd edition), Chapman & Hall/CRC Press.  
4. Harrison, E. & Pius, R. (2021) R for Health Data Science, CRC Press, Taylor and Francis Group.  
5. Crawley, M.J. (2015) Statistics An Introduction using R, Second Edition, John Wiley & Sons Ltd.  
