clams.coll <- loadClamsDir("C:/Users/Katherine/Documents/CLAMS-Projects/Data/Jess")

clams.coll <- selectColumns(clams.coll, col.names=c("INTERVAL", "CHAN", "DATE.TIME", "VO2", "VCO2", "HEAT", "RER", 
                                                    "FEED1.ACC", "XTOT", "XAMB", "YTOT", "YAMB", "BODY.TEMP" ), 
                            do.remove.outliers=TRUE)

clams.coll <- appendColumn(clams.coll, "temp.30", TRUE, 
                           start.str="06/29/2015 06:00:00 AM", stop.str="07/01/2015 06:00:00 AM")
clams.coll <- appendColumn(clams.coll, "temp.22", TRUE, 
                           start.str="07/01/2015 06:00:00 AM", stop.str="07/04/2015 06:00:00 AM")
clams.coll <- appendColumn(clams.coll, "temp.4", TRUE, 
                           start.str="07/04/2015 06:00:00 AM", stop.str="07/07/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "orig.weight", c(38.1, 36.1, 28.5, 31.3, 35.2, 36.9, 29.9, 31.1, 32.1,
                                                      27.5, 31.9, 28.3, 21.8, 30.5))

clams.coll <- appendColumn(clams.coll, "adj.weight", c(38.1, 36.1, 28.5, 31.3, 35.2, 36.9, 29.9, 31.1, 32.1,
                                                       27.5, 31.9, 28.3, 21.8, 30.5),
                           start.str="06/29/2015 06:00:00 AM", stop.str="07/01/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "adj.weight", c(38.1, 36.1, 28.5, 31.3, 35.2, 36.9, 29.9, 31.1, 32.1,
                                                       27.5, 31.9, 28.3, 21.8, 30.5),
                           start.str="07/01/2015 06:00:00 AM", stop.str="07/04/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "adj.weight", c(38.1, 36.1, 28.5, 31.3, 35.2, 36.9, 29.9, 31.1, 32.1,
                                                       27.5, 31.9, 28.3, 21.8, 30.5),
                           start.str="07/04/2015 06:00:00 AM", stop.str="07/07/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "do.plot", TRUE)

clams.coll <- appendColumn(clams.coll, "light", TRUE, 
                           start.str="06:00:00 AM", stop.str="06:00:00 PM", is.daily=TRUE)
clams.coll <- appendColumn(clams.coll, "dark", TRUE, 
                           start.str="06:00:00 PM", stop.str="06:00:00 AM", is.daily=TRUE)

clams.coll <- adjustMeasurement(clams.coll, "VO2")
clams.coll <- adjustMeasurement(clams.coll, "VCO2")

clams.msr <- alignMeasurement(clams.coll, "ADJ.VO2", c("LIGHT", "DARK", "TEMP.30", "TEMP.22", "TEMP.4"))

plotMeasurement(clams.msr, "Oxygen Consumption, ml/kg/hr", "VO2-TEST.pdf",
                agg.names=list(c("JH619", "JH620", "JH621"), 
                               c("JH396", "JH397", "JH546", "JH546.1", "JH549", "JH547", "JH546.2")),
                agg.labels=c("WT", "A/A"),
                con.names=c("TEMP.30", "TEMP.22", "TEMP.4"),
                con.labels=expression(paste("30", degree, "C"), paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter="c", do.error.bars=TRUE, legend.coord="bottomright")

clams.msr <- alignMeasurement(clams.coll, "HEAT", c("LIGHT", "DARK", "TEMP.30", "TEMP.22", "TEMP.4"))

plotMeasurement(clams.msr, "Heat/Energy Expenditure, kcal/hour", "Heat-TEST.pdf",
                agg.names=list(c("JH619", "JH620", "JH621"), 
                               c("JH396", "JH397", "JH546", "JH546.1", "JH549", "JH547", "JH546.2")),
                agg.labels=c("WT", "A/A"),
                con.names=c("TEMP.30", "TEMP.22", "TEMP.4"),
                con.labels=expression(paste("30", degree, "C"), paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter="c", do.error.bars=TRUE, legend.coord="bottomright")




