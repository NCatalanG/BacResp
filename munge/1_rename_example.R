DOM_CB<-renormalized.crosstab.BAB.MF.that.had.polyisotopicMF.marked


noms<-colnames(DOM_CB[27:length(DOM_CB)])
file.nams <- vapply(strsplit(noms, "[\\_]"), "[", i = 1, "")
file.nams
colnames(DOM_CB)[27:length(DOM_CB)]<- file.nams
colnames(DOM_CB)

DOM_CB<-DOM_CB[,c(1:26, 27, 38,49,58:63, 28:37, 39:48, 50:57)]

rm (noms,file.nams,renormalized.crosstab.BAB.MF.that.had.polyisotopicMF.marked)