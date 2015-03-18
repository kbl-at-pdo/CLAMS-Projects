data.o <- read.csv("Data/Anal Desai/CCL4 Microarray IPA.csv")
data.x <- data.o[data.o$LOG.MT.1>0,]
write.csv(data.x,"Data/Anal Desai/CCL4 Microarray IPA extracted.csv")