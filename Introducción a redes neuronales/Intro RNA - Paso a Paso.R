install.packages("neuralnet")
library(neuralnet)

# ------ Intro. a Redes Neuronales Artificiales ------#

# Objetivo: generar un modelo de clasificación binomial

# ----------------------------------------------------#

# Crear base de datos 

Edad <- c(60,20,25,70,80,40,30,50,25,21,70,50,40,75,35)
Trigliceridos <- c(300,100,120,400,250,130,200,400,120,400,250,300,
                   250,400,200)
Infarto <- c(1,0,0,1,1,0,0,1,0,0,1,1,0,1,0)

data <- data.frame(Edad, Trigliceridos, Infarto)

# Dividir en training y test

sample_data <- sample(nrow(data), nrow(data)/3)

training_data <- data[-sample_data,]
test_data <- data[sample_data,]

# Crear base de datos predicción

Edad <- c(90,86,20,25,86)
Trigliceridos <- c(400,200 ,100,120,330)

prediction_data <- data.frame(Edad, Trigliceridos)

# normalización de los datos

maxs <- apply(X = training_data, MARGIN = 2, FUN = max)
mins <- apply(X = training_data, MARGIN = 2, FUN = min)

maxs
mins

training_data_nrm <- data.frame(scale(x=training_data,center = mins,
                                      scale = maxs-mins))

maxs <- apply(test_data, 2, max)
mins <- apply(test_data, 2, min)

maxs
mins

test_data_nrm <- data.frame(scale(x = test_data, center = mins, 
                                  scale = maxs-mins))

# Normalizar los datos de predicción

maxs <- apply(prediction_data, 2, max)
mins <- apply(prediction_data, 2, min)

maxs
mins

prediction_data_nrm <- data.frame(scale(x = prediction_data, center = mins, 
                                        scale = maxs-mins))

# Generar NN y graficar

rn <- neuralnet(Infarto~Edad + Trigliceridos, data = training_data_nrm,
                hidden = 4, threshold = 0.02, act.fct = "logistic",
                err.fct = "sse", rep = 5, algorithm = "backprop",
                learningrate = 0.001)
rn

rn2 <- neuralnet(Infarto~Edad + Trigliceridos, data = training_data_nrm,
                hidden = 4, threshold = 0.02, act.fct = "logistic",
                err.fct = "sse", rep = 5, algorithm = "rprop+")

rn2

plot(rn, rep = "best")
plot(rn2, rep = "best")

# evaluar con el test

rn_pred <- compute(x = rn, covariate = test_data_nrm, rep = 1)

a <- rn_pred$net.result
cond_predition <- ifelse(test = a>0.5, yes = 1, no = 0)

cond_predition
test_data


