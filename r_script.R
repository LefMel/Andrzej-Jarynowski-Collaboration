getwd()
setwd("/Users/lefmel/Documents/Publications//Andrzej Jarynowski Collaboration/Data")
getwd()

list.files()
library(openxlsx)

draft = read.xlsx("syndormalka.xlsx")
names(draft)
draft[,c("Week")]
data = draft[,c("Week", "wave_parts", "waves", "Incid+/Synd+","Incid+/Synd-", "Incid-/Synd+", "Incid-/Synd-")]
names(data)


library(runjags)
?template_huiwalter

Se <- list(chain1=c(0.5,0.99), chain2=c(0.99,0.5))
Sp <- list(chain1=c(0.5,0.99), chain2=c(0.99,0.5))

setwd("/Users/lefmel/Documents/Publications//Andrzej Jarynowski Collaboration")
model_data = data[1:100,c(4:7)]
N = 100
names(model_data)
names = c("Pos_Pos", "Pos_Neg", "Neg_Pos", "Neg_Neg")
colnames(model_data) = names

model_data = as.matrix(model_data)
model <- run.jags("model_jags")

View(summary(model))
plot(model)


################

data_1 = c(data$`Incid+/Synd+`[2], data$`Incid+/Synd-`[2], data$`Incid-/Synd+`[2], data$`Incid-/Synd-`[2])
data_2 = c(data$`Incid+/Synd+`[3], data$`Incid+/Synd-`[3], data$`Incid-/Synd+`[3], data$`Incid-/Synd-`[3])

p = 2
N_1 = sum(data_1)
N_2 = sum(data_2)
