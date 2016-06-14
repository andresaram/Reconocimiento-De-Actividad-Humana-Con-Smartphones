---
output: pdf_document
---
##FACULTAD DE CIENCIAS FISICO MATEMATICAS
##LICENCIATURA EN ACTUARIA
##PROGRAMACION ACTUARIAL III
### Caso #3: Reconocimiento De Actividad Humana Con SmartPhones
El proposito de este proyecto es demostrar habilidad para recolectar, trabajar y limpiar base de datos ademas de preparar un conjunto ordenado de informacion que pueda ser trabajado en analisis posteriores.

###Archivos en el proyecto

$\bullet$ ./data/UCHI HAR Datasets

$\bullet$ README.md

$\bullet$ CodeBook.md

$\bullet$ correr_analisis.R

###Explicacion de: "correr_analisis.R"
1.- Veamos que dentro de la funcion hay una parte que dice lo siguiente:



**features <- read.table(filee("features.txt"))[,2]**
  **colnames(datatot) <- features**



Aqui lo unico que hace es extraer las medidas de la media, ademas de que



  **prom <- grepl('-(mean|std)\\(',features)**
  
  
  
  
 
tal linea de codigo es la encargada de buscar coincidencias entre argumentos o patrones y finalizamos actualizando estas medidas seleccionadas para que esten en "data_set"



 **datatot <- subset(datatot,select=prom)**

  **datatot[1:4,1:5]**
  
Siguiendo con esto, en el codigo se presenta lo siguiente:



**colnames(datatot) <- gsub("mean", "Mean", colnames(datatot))**
  
**colnames(datatot) <- gsub("std", "Std", colnames(datatot))**
  
**colnames(datatot) <- gsub("^t", "Time", colnames(datatot))**
 
**colnames(datatot) <- gsub("^f", "Frequency", colnames(datatot))**

**colnames(datatot) <- gsub("\\(\\)", "", colnames(datatot))**
  
**colnames(datatot) <- gsub("-", "", colnames(datatot))**
 
**colnames(datatot) <- gsub("BodyBody", "Body", colnames(datatot))**

**colnames(datatot) <- gsub("^", "MeanOf", colnames(datatot))**
  
**colnames(datatot)**

**datatot[1:4,1:5]**



Lo que estamos haciendo es colocar las etiquetas necesarias a cada conjunto de datos, despues nombramos cada conjunto de datos:



  **acttra <- read.table(filee("train/y_train.txt"))**
  
  **actte <- read.table(filee("test/y_test.txt"))**
  
  **activ <- rbind(acttra,actte)[,1]**
  
  **etiquetas <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",**
  
   **"SITTING", "STANDING", "LAYING")**
   
  **activ <- etiquetas[activ]**
  
  **datatot <- cbind(Activity = activ,datatot)**
  
  **datatot[1:4,1:5]**
  
  
  
Nos vamos a interesamos en la dirección que nos lleva a cada uno de los voluntarios(30). Lo que hacemos es combinar filas y después actualizaremos "data_set" para que aparezcan los voluntarios como una columna.



**sujetos_tra <- read.table(filee("train/subject_train.txt"))**

**sujetos_te <- read.table(filee("test/subject_test.txt"))**

**sujetos <- rbind(sujetos_tra,sujetos_te)[,1]**

**datatot <- cbind(sujetos = sujetos,datatot)**

**datatot[1:4,1:5]**


  
Para concluir usaremos el paquete "dplyr" el cual nos ayudara a manipular todo lo que llevamos hasta ahora. Creamos una segunda base de datos en donde vendran los promedios de cada variable dicha para cada actividad y cada voluntario en total.




**library('dplyr')**

**prom_data <- datatot %>%**

**group_by(sujetos,Activity) %>%**

**summarise_each(funs(mean))**


y creamos un archivo llamado: "conjunto de datos ordenados"

**write.table(prom_data,row.name = FALSE,file = "conjunto_de_datos_ordenados")**
 
 
---
*Andrés Aram De la Calleja Macip 201303710*
---
