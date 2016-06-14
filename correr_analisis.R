correr_analisis <- function(){
  
  datadirec <- "UCI HAR Dataset"
  
  filee <- function(...) { paste(datadirec,...,sep="/") }
  
  training <- read.table(filee("train/X_train.txt"))
  test <- read.table(filee("test/X_test.txt"))
  datatot <- rbind(training,test)
  datatot[1:4,1:5]
  rm(test,training)
  
  features <- read.table(filee("features.txt"))[,2]
  colnames(datatot) <- features
  prom <- grepl('-(mean|std)\\(',features)
  datatot <- subset(datatot,select=prom)
  datatot[1:4,1:5]
  
  
  
  colnames(datatot) <- gsub("mean", "Mean", colnames(datatot))
  colnames(datatot) <- gsub("std", "Std", colnames(datatot))
  colnames(datatot) <- gsub("^t", "Time", colnames(datatot))
  colnames(datatot) <- gsub("^f", "Frequency", colnames(datatot))
  colnames(datatot) <- gsub("\\(\\)", "", colnames(datatot))
  colnames(datatot) <- gsub("-", "", colnames(datatot))
  colnames(datatot) <- gsub("BodyBody", "Body", colnames(datatot))
  colnames(datatot) <- gsub("^", "MeanOf", colnames(datatot))
  colnames(datatot)
  datatot[1:4,1:5]
  
  acttra <- read.table(filee("train/y_train.txt"))
  actte <- read.table(filee("test/y_test.txt"))
  activ <- rbind(acttra,actte)[,1]
  etiquetas <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
              "SITTING", "STANDING", "LAYING")
  activ <- etiquetas[activ]
  datatot <- cbind(Activity = activ,datatot)
  datatot[1:4,1:5]
  
  sujetos_tra <- read.table(filee("train/subject_train.txt"))
  sujetos_te <- read.table(filee("test/subject_test.txt"))
  sujetos <- rbind(sujetos_tra,sujetos_te)[,1]
  datatot <- cbind(sujetos = sujetos,datatot)
  datatot[1:4,1:5]
  
  library('dplyr')
  prom_data <- datatot %>%
    group_by(sujetos,Activity) %>%
    summarise_each(funs(mean))
  
  write.table(prom_data,row.name = FALSE,file = "conjunto_de_datos_ordenados")
}