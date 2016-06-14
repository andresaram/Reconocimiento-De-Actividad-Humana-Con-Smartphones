---
output: html_document
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

**features_name <- read.table(file_path("features.txt"))[,2]**
  **colnames(data_set) <- features_name**

Aqui lo unico que hace es extraer las medidas de la media, ademas de que

 **selected_measures <- grepl('-(mean|std)\\(',features_name)**
 
tal linea de codigo es la encargada de buscar coincidencias entre argumentos o patrones y finalizamos actualizando estas medidas seleccionadas para que esten en "data_set"

 **data_set <- subset(data_set,select=selected_measures)**
  **data_set[1:4,1:5]**
  
Siguiendo con esto, en el codigo se presenta lo siguiente:

**colnames(data_set) <- gsub("mean", "Mean", colnames(data_set))**
  
**colnames(data_set) <- gsub("std", "Std", colnames(data_set))**
  
**colnames(data_set) <- gsub("^t", "Time", colnames(data_set))**
 
**colnames(data_set) <- gsub("^f", "Frequency", colnames(data_set))**

**colnames(data_set) <- gsub("\\(\\)", "", colnames(data_set))**
  
**colnames(data_set) <- gsub("-", "", colnames(data_set))**
 
**colnames(data_set) <- gsub("BodyBody", "Body", colnames(data_set))**

**colnames(data_set) <- gsub("^", "MeanOf", colnames(data_set))**
  
**colnames(data_set)**

**data_set[1:4,1:5]**

Lo que estamos haciendo es colocar las etiquetas necesarias a cada conjunto de datos, despues nombramos cada conjunto de datos:

activities_train <- read.table(file_path("train/y_train.txt"))
  activities_test <- read.table(file_path("test/y_test.txt"))
  activities <- rbind(activities_train,activities_test)[,1]
    labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
              "SITTING", "STANDING", "LAYING")
  activities <- labels[activities]
  data_set <- cbind(Activity = activities,data_set)
  data_set[1:4,1:5]
  
Nos vamos a interesamos en la dirección que nos lleva a cada uno de los voluntarios(30). Lo que hacemos es combinar filas y después actualizaremos "data_set" para que aparezcan los voluntarios como una columna.

 subjects_train <- read.table(file_path("train/subject_train.txt"))
  subjects_test <- read.table(file_path("test/subject_test.txt"))
  subjects <- rbind(subjects_train,subjects_test)[,1]
  data_set <- cbind(Subject = subjects,data_set)
  data_set[1:4,1:5]
  
Para concluir usaremos el paquete "dplyr" el cual nos ayudara a manipular todo lo que llevamos hasta ahora. Creamos una segunda base de datos en donde vendrán los promedios de cada variable dicha para cada actividad y cada voluntario en total.


library('dplyr')
  average_data_set <- data_set %>%
    group_by(Subject,Activity) %>%
    summarise_each(funs(mean))
    
y creamos un archivo llamado: "conjunto de datos ordenados"

 write.table(average_data_set,row.name = FALSE,file = "conjunto_de_datos_ordenados")
---
*Andrés Aram De la Calleja Macip 201303710*
---
