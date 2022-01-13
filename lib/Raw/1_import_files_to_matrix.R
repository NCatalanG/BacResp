#setwd("N:/Dropbox/A_NURIA/AA_RECERCA/2_RUNNING_PROJECTS_INSTITUTIONAL/10_CANTERA/PROVATINA INCUBACIONS/resultatsprovatina/raw")
#require(dplyr) #you will need to do install.packages ("dplyr") before for the 1st time
#1.- import files####
file_list <- list.files()
file.nams <- vapply(strsplit(file_list, "[\\.]"), "[", i = 1, "")
file.names <- vapply(strsplit(file.nams, "_"), "[", i = 2, "")
file.names
chanel<-vapply(strsplit(file.nams, "_"), "[", i = 2, "")
chanel <- vapply(strsplit(chanel, "-"), "[", i = 2, "")
file.names <- c("Reg_Blank", "Reg_F1", "Reg_F1_HS","Fui_Blank","Fui_F1", "Fui_F1_HS")#only for CANTERA provatina

DataBR <- read.table(file_list[1],skip = 37,header = T,
                   sep = ";",dec = ",",na.strings = "")
DataBR$sample<- c(rep(file.names[1],nrow(DataBR)))
DataBR$Min<-c(0,0.02,seq(0.15,to=(nrow(DataBR)-2)*0.25,by=0.25))
DataBR<-DataBR %>% filter(between(Min, 60, 2700))

for (f in seq (along = file_list)[-1]) {
  dat <- read.table(file_list[f],skip = 37,header = T,sep = ";",dec = ",",na.strings = "")
  dat$sample<- c(rep(file.names[f],nrow(dat)))
  dat$Min<-c(0,0.02,seq(0.15,to=(nrow(dat)-2)*0.25,by=0.25))
  dat<-dat %>% filter(between(Min, 60, 2700))
  DataBR <- rbind (DataBR,dat)
}
colnames(DataBR)<-c("Date","Time", "Minutes", "O2", "Phase", "Amp", "Temp", "Sample","Min")
library(lattice)
xyplot( (O2)~Minutes, DataBR, groups = Sample, 
        type = c( "smooth"),
        auto.key = list(space = "right", lines = TRUE), #aspect = "xy",
        xlab = "Time (min)", ylab = "O2 (mgL-1)",xlim=c(0,2700))

#2.- transform into a wide matrix as respR wants and get ready for treatment####
library(tidyverse)
DataBRlong<-DataBR[,c(8,9,4)]

wideBR = DataBRlong %>% 
  pivot_wider(names_from = Sample, values_from = O2)
wideBR<-wideBR[complete.cases(wideBR), ]

#library(drc)
#library(nlme)
#install.packages("devtools")
#library(devtools)
#devtools::install_github("januarharianto/respR")


