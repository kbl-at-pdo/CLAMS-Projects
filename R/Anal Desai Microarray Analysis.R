data.o <- read.csv("Data/Anal Desai/CCL4 Microarray IPA.csv")

data.o$NEW.WT.MEAN <- apply(data.o[,c("LOG2.WT1", "LOG.WT.2", "LOG.WT.3")],1,mean) 
data.o$WT.SD <- apply(data.o[,c("LOG2.WT1", "LOG.WT.2", "LOG.WT.3")],1,sd) 

data.o$LOG2.WT1.VALID <- 1

data.o$LOG2.WT1.VALID[
  (data.o$LOG2.WT1 > (data.o$NEW.WT.MEAN) + 2.0 * data.o$WT.SD | 
     data.o$LOG2.WT1 < (data.o$NEW.WT.MEAN - 2.0 * data.o$WT.SD))] <- 0


                              
                              
                              
                              
  
  