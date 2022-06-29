library(C50)
library(caret)
library(dplyr)

setwd("D:/")

data_ha <- read.csv("data/heart.csv")
str(data_ha)

sum(is.na(data_ha))
str(data_ha)

#change data structure
data_ha$sex <- as.factor(data_ha$sex)
data_ha$cp <- as.factor(data_ha$cp)
data_ha$fbs <- as.factor(data_ha$fbs)
data_ha$restecg <- as.factor(data_ha$restecg)
data_ha$exng <- as.factor(data_ha$exng)

data_ha$output <- as.factor(data_ha$output)

data_ha <- data_ha%>%
  select(-c(slp, caa, thall))

str(data_ha)

##C50 model
model_C50 <- C5.0(output ~ ., data_ha, trials = 10)
summary(model_C50)

##coba model
n_predict <- predict(model_C50, data_ha[-11])
n_actual <- data_ha$output
confusionMatrix(n_predict, n_actual)

#simpan model
saveRDS(model_C50, "data/model_C50.RDS")
model_C50 <- readRDS("data/model_C50.RDS")

data_baru <- data.frame(
  nama = "Pasien B",
  age = 65,
  sex = factor(1),
  cp = factor(0),
  trtbps = 167,
  chol = 203,
  fbs = factor(1),
  restecg = factor(0),
  thalachh = 189,
  exng = factor(1),
  oldpeak =1.3
)

if(predict(model_C50, data_baru) == 0){
  print(paste(data_baru[1,1], "beresiko rendah menderita penyakit jantung"))
}else{
  print(paste(data_baru[1,1], "beresiko tinggi menderita penyakit jantung"))
}

