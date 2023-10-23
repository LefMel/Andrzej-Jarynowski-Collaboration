getwd()
setwd("C:/Users/LefMel/Documents/Publications-Analyses/Andrzej-Jarynowski-Collaboration/Data")
getwd()

list.files()
library(openxlsx)

draft = read.xlsx("syndormalka.xlsx")
draft = draft[1:100,]
names(draft)
draft[,c("Week")]
data = draft[,c("Week", "wave_parts", "waves", "Incid+/Synd+","Incid+/Synd-", "Incid-/Synd+", "Incid-/Synd-")]
names(data)


library(runjags)
setwd("C:/Users/LefMel/Documents/Publications-Analyses/Andrzej-Jarynowski-Collaboration")

# 1st model (per wave_part)
data_1 = aggregate(data[,c(4:7)], by = list(data$wave_parts), sum)
data_1 = data_1[c(1,3),]
N1 = rep(NA,2)
N1[1] = sum(data_1[1,2:5])
N1[2] = sum(data_1[2,2:5])
data_1 = data_1[,-1]


model_1_res <- run.jags("model_1.txt", data=list(data_1 = as.matrix(data_1), N1 = N1))
summary(model_1_res)


# 2nd model (per wave)
data_2 = aggregate(data[,c(4:7)], by = list(data$waves), sum)
data_2 = data_2[c(1:4),]
N2 = rep(NA,4)
N2[1] = sum(data_2[1,2:5])
N2[2] = sum(data_2[2,2:5])
N2[3] = sum(data_2[3,2:5])
N2[4] = sum(data_2[4,2:5])
data_2 = data_2[,-1]


model_2_res <- run.jags("model_2", data=list(data_2 = as.matrix(data_2), N2 = N2))
summary(model_2_res)

# 3rd model

model_3_res <- run.jags("model_jags", data =list(model_data=as.matrix(data[,4:7])))
View(summary(model_3_res))

