data.o <- read.csv("Data/Anal Desai/CCL4 Microarray IPA.csv")
data.x <- data.o[data.o$LOG.MT.1>0,]
write.csv(data.x,"Data/Anal Desai/CCL4 Microarray IPA x.csv")

data.y <- data.o[mean(
  data.o$LOG.MT.1) - 3.0 * sd(data.o$LOG.MT.1) < data.o$LOG.MT.1 &
    data.o$LOG.MT.1 < mean(data.o$LOG.MT.1) + 3.0 * sd(data.o$LOG.MT.1),
  ]

write.csv(data.y,"Data/Anal Desai/CCL4 Microarray IPA y.csv")


## All WT <- "C2Plus_1771B", "C3Plus_1771D", "C4Plus_1771F"

x <- c(data.o$LOG2.WT1[1], data.o$LOG.WT.2[1], data.o$LOG.WT.3[1])

mean.x <- mean(x)

mean(x) - 