source('./R/loadClamsFile.R', echo=TRUE)
source('./R/loadClamsDir.R', echo=TRUE)
source('./R/selectColumns.R', echo=TRUE)
source('./R/appendColumn.R', echo=TRUE)
source('./R/alignMeasurement.R', echo=TRUE)
source('./R/plotMeasurement.R', echo=TRUE)

data.dir <- "C:\\Users\\Katherine\\Documents\\CLAMS\\CLAMS runs\\Shannon Carroll\\Experiment 1"
data.fls <- c("2015-01-06 Experiment 1.0101.CSV",
              "2015-01-06 Experiment 1.0102.CSV",
              "2015-01-06 Experiment 1.0103.CSV",
              "2015-01-06 Experiment 1.0104.CSV",
              "2015-01-06 Experiment 1.0105.CSV")

clams.coll.j <- list()

#All of this is true for all subjects/files 1.0101 - 1.0105 NH, HR, HL, LL, RL 
orig.weight <- c(23.8, 25.8, 22.6, 25.5, 25.5)
genotype <- c("KO", "WT", "KO", "KO", "WT")
adj.weight.22 <- c(23.5, 24.3, 22.6, 22.4, 24.9)
adj.weight.4 <- c(22.7, 24.2, 22.6, 25.1, 24.3)



for(i.fls in seq(1, length(data.fls))) {
  clams.data.a <- loadClamsFile(file.path(data.dir, data.fls[i.fls]))
  
  clams.data.b <- selectColumns(clams.data.a, do.remove.outliers=TRUE) 
  
  clams.data.c <- appendColumn(clams.data.b, "light", TRUE, 
                               start.str="06:00:00 AM", stop.str="06:00:00 PM", is.daily=TRUE)
  clams.data.d <- appendColumn(clams.data.c, "dark", TRUE, 
                               start.str="06:00:00 PM", stop.str="06:00:00 AM", is.daily=TRUE)
  clams.data.e <- appendColumn(clams.data.d, "temp.22", TRUE, 
                               start.str="01/08/2015 06:00:00 AM", stop.str="01/09/2015 06:00:00 AM")
  clams.data.f <- appendColumn(clams.data.e, "temp.4", TRUE, 
                               start.str="01/11/2015 06:00:00 AM", stop.str="01/12/2015 06:00:00 AM")
  
  
  clams.data.g <- appendColumn(clams.data.f, "orig.weight", orig.weight[i.fls])
  
  
  clams.data.h <- appendColumn(clams.data.g, "genotype", genotype[i.fls])
  
  
  clams.data.i <- appendColumn(clams.data.h, "adj.weight", adj.weight.22[i.fls], 
                               start.str="01/08/2015 06:00:00 AM", stop.str="01/09/2015 06:00:00 AM")
  
  data.fnm <- data.fls[i.fls]  
  clams.coll.j[[data.fnm]] <- appendColumn(clams.data.i, "adj.weight", adj.weight.4[i.fls], 
                                        start.str="01/11/2015 06:00:00 AM", stop.str="01/12/2015 06:00:00 AM")
  clams.coll.j[[data.fnm]]$measurements$ADJ.VO2 <- 
    clams.coll.j[[data.fnm]]$measurements$VO2 / 
    clams.coll.j[[data.fnm]]$measurements$ORIG.WEIGHT * 
    clams.coll.j[[data.fnm]]$measurements$ADJ.WEIGHT
}

clams.msr <- alignMeasurement(clams.coll.j, "VO2", c("LIGHT", "DARK","TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Oxygen Consumption, ml/kg/hr", "VO2.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "ADJ.VO2", c("LIGHT", "DARK","TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Oxygen Consumption, ml/kg/hr", "ADJ.VO2.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "VCO2", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Carbon Dioxide Production, ml/kg/hr", "VCO2.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "RER", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Respiratory Exchange Ratio, RER", "RER.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "HEAT", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Energy Expenditure, kcal/hour", "HEAT.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "XTOT", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Total Activity, beam breaks", "XTOT.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "XAMB", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Ambulatory Activity, consecuative beam breaks", "XAMB.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)

clams.msr <- alignMeasurement(clams.coll.j, "FEED1.ACC", c("LIGHT", "DARK", "TEMP.22", "TEMP.4"))
plotMeasurement(clams.msr, "Food Intake, grams", "FEED.pdf",
                agg.names=list(c("HR", "RL"), c("NH", "HL", "LL")),
                agg.labels=c("WT", "KO"),
                con.names=c("TEMP.22", "TEMP.4"),
                con.labels=expression(paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter=TRUE, do.error.bars=TRUE)




