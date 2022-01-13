#3.- package respR####
data(package = "respR")
#using package respiration to select the best section for the linear fit
blank <- inspect(wideBR, time = 1, oxygen = 2)
n=1 #number of sample to treat (we could start a loop from here)
mostra <- inspect(wideBR, time = 1, oxygen = 2+n)

bg<-calc_rate.bg(blank)
crate<-calc_rate(mostra) 
adjust_rate(mostra$summary,bg)
#rate <- calc_rate(mostra, from = 5, to = 30, by = "time")
summary(crate)
#plot(rate)
# Perform linear detection; default width (when not specified) is 0.2:
arate <- auto_rate(wideBR[,c(1,2+n)],plot = T, method="linear")
araconv<-convert_rate(arate, 
                      o2.unit = "mg/L", 
                      time.unit = "min", 
                      output.unit = "mg/h", 
                      volume = 0.02, )
araconv
# Perform linear detection using manual width of 0.6:
#overx <- auto_rate(wideBR[,c(1,1+n)], plot = T)
#overx
#automatic maximal rate
mxrate<-auto_rate(wideBR[,c(1,1+n)], plot=T, method = "max")
#summary(mxrate)
mxraconv<-convert_rate(mxrate, 
                       o2.unit = "mg/L", 
                       time.unit = "min", 
                       output.unit = "mg/h", 
                       volume = 0.02)
mxraconv
#4.- non linear exponential fit#####
# Select an approximate $\theta$, since theta must be lower than min(y), and greater than zero
data1<-wideBR[c(1100:nrow(wideBR)),c(1,1+n)]
colnames(data1)<- c("Min","O2")
theta.0 <- min(data1$O2) * 0.5  

# Estimate the rest parameters using a linear model
model.0 <- lm(log(O2 - theta.0) ~ Min, data=(data1)) 
plot((data1$Min),(data1$O2))
aa.0 <-exp(coef(model.0)[1])
kk.0 <- (coef(model.0)[2])

# Starting parameters
start <- list(kk = kk.0, theta = theta.0,aa=aa.0)
start
#fit the model
model <- nls(O2 ~ aa * exp(kk * Min) + theta , 
             data = data1, start = start, control = list(maxiter = 500,minFactor=0.00001))
summary(model) #u will see this model does nto converge for "weird" curves
#plot(profile(model))
plot(data1$Min, data1$O2)
lines(data1$Min, predict(model, list(x = data1$Min)), col = 'skyblue', lwd = 3)

#create output matrix:
OUTPUTBR<-matrix(nrow=length(file_list),ncol=7)
colnames(OUTPUTBR)<-c("chanel","Overall rate","linO2 mg/L/H","linO2 mg/h","maxO2 mg/L/H", "maxO2 mg/h","expO2 mg/L/H")
rownames(OUTPUTBR)<-colnames(wideBR[,c((1+n):ncol(wideBR))])
OUTPUTBR[,1]<-chanel
OUTPUTBR[n,2]<-crate$summary$rate_b1 [1]
OUTPUTBR[n,3]<-arate$summary$rate_b1 [1]
OUTPUTBR[n,4]<-araconv$output [1]
OUTPUTBR[n,5]<-mxrate$summary$rate_b1 [1]
OUTPUTBR[n,6]<-mxraconv$output [1]
#OUTPUTBR[n,7]<-summary(model)$parameters [1]

#5.- plot rates from output and export####
OUTPUTBR<-as.data.frame(OUTPUTBR)
plot(OUTPUTBR[,6])
colnames(OUTPUTBR)
library(ggplot2)
ggplot(OUTPUTBR, aes(x=factor(chanel), y=`expO2 mg/L/H`)) + 
  geom_boxplot()
library(dplyr)
OUTPUTBR$chanel<-as.factor(OUTPUTBR$chanel)
OUTPUTBR %>% group_by(chanel) %>% boxplot(var1, var2)

write.csv(OUTPUTBR,"N:\\Dropbox\\A_NURIA\\AA_RECERCA\\1_RUNNING_PROJECTS_NON_INSTITUTIONAL\\14_ADA\\ARTIC\\2019_CAMBRIDGE_BAY\\RESULTS\\RESPIRATION_raw\\NUNAVUT_BR.csv", row.names = T)



########################################
##########ADITIONAL STUFF###############
# Fit single exponential model S = S0 exp (-kt)####
expmodel=nls(O2~data1$O2[1]*exp(kkkexp*Min),data=data1,na.action=na.omit,start=c(kkkexp=0.0001))
summary(expmodel)
expk<-matrix(ncol=1,nrow=9461)
xxp=seq(0,2800,1);yyp1=matrix(ncol=6,nrow=length(xxp));yyp2=matrix(ncol=6,nrow=length(xxp))
expk[1]=coef(expmodel)[1]
yyp2=data1$O2[1]*exp(coef(expmodel)[1]*xxp);
plot((data1$O2)~(data1$Min))
lines(xxp,yyp2,lwd=2,col="blue",ylim=c(0,12))
#for this simple models, I have a loop including goodness of fit validation (approach as Mostovaya for MS data)


# DISCARDED Fit single exponential model S = S0 -b*exp (-kt))####
expmodel=nls(O2 ~ data1$O2[1]- b*exp(kkkexp*Min), data=data1,na.action=na.omit,start=c(kkkexp=0.0001,b=1))
summary(expmodel)
expk<-matrix(ncol=1,nrow=6)
xxp=seq(0,2800,1);yyp1=matrix(ncol=6,nrow=length(xxp));yyp2=matrix(ncol=6,nrow=length(xxp))
expk[1]=coef(expmodel)[1]
yyp2=data1$O2[1]-(coef(expmodel)[2])*exp(coef(expmodel)[1]*xxp);
plot((data1$O2)~(data1$Min))
lines(xxp,yyp2,lwd=2,col="blue",ylim=c(0,12))

# Fit exponential model S = a + (S0-a) exp(-t/c) using function drm####
#(I do it manually changing the name of the 6 treatments, although drm accepts adding treatment as grouping variable)
require(drc)
resp.m1<-drm(O2~Min, data=data1, fct=EXD.3(fixed=c(NA,data1$O2[1],NA)))
plot(resp.m1,log="")
summary(resp.m1)
coef(resp.m1)
time = data.frame(t=seq(0,2000,1))
time$o2<-(predict(resp.m1, newdata = time))
plot(resp.m1, broken=TRUE, xlab="Time", ylab="Oxygen", lwd=1, 
     cex=1.2, cex.axis=1.2, cex.lab=1.2)


##respirometry package calculates the change between every two points####
require (respirometry)
plot(Data1$Min,data1$O2)
(mo2_1_h_SS.3 <- calc_MO2(duration = data1$Min, o2_unit="mg_per_l",o2 = data1$O2,
                          bin_width = 0, vol = 0.02, temp = 20))
mo2_1_h_SS.3$MO2ppm<-mo2_1_h_SS.3$MO2*32/1000
