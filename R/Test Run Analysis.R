
## Loading CLAMS data for a test run of the three new CLAMS systems
clams.coll <- loadClamsDir("C:/Users/Katherine/Documents/CLAMS-Projects/Data/Test_Run")

## Removing outliers and selecting some columns (Removing columns of data typically not used in analaysis)

clams.coll <- selectColumns(clams.coll, col.names=c("INTERVAL", "CHAN", "DATE.TIME", "VO2", "VCO2", "HEAT", "RER", 
                                                    "FEED1.ACC", "XTOT", "XAMB", "YTOT", "YAMB", "BODY.TEMP" ), 
                            do.remove.outliers=TRUE)

## clams.coll <- selectColumns(clams.coll, do.remove.outliers=TRUE) 

clams.coll <- appendColumn(clams.coll, "temp.30", TRUE, 
                           start.str="06/29/2015 06:00:00 AM", stop.str="07/01/2015 06:00:00 AM")
clams.coll <- appendColumn(clams.coll, "temp.22", TRUE, 
                           start.str="07/01/2015 06:00:00 AM", stop.str="07/04/2015 06:00:00 AM")
clams.coll <- appendColumn(clams.coll, "temp.4", TRUE, 
                           start.str="07/04/2015 06:00:00 AM", stop.str="07/07/2015 06:00:00 AM")
clams.coll <- appendColumn(clams.coll, "orig.weight", c(25.2, 25.3, 22.5, 27.3, 27.2, 25.2, 26.5, 29.7, 27.7))

##Supplying bodyweight forthe 3 different temperatures: 30, 22 and 4 degrees

clams.coll <- appendColumn(clams.coll, "adj.weight", c(25.2, 25.3, 22.5, 27.3, 27.2, 25.2, 26.5, 29.7, 27.7),
                           start.str="06/29/2015 06:00:00 AM", stop.str="07/01/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "adj.weight", c(25.2, 25.3, 22.5, 27.3, 27.2, 25.2, 26.5, 29.7, 27.7),
                           start.str="07/01/2015 06:00:00 AM", stop.str="07/04/2015 06:00:00 AM")

clams.coll <- appendColumn(clams.coll, "adj.weight", c(25.2, 25.3, 22.5, 27.3, 27.2, 25.2, 26.5, 29.7, 27.7),
                           start.str="07/04/2015 06:00:00 AM", stop.str="07/07/2015 06:00:00 AM")

## Adding in light and dark periods 12/12 Light dark cycle starting at 6 AM going to 6 PM
clams.coll <- appendColumn(clams.coll, "light", TRUE, 
                           start.str="06:00:00 AM", stop.str="06:00:00 PM", is.daily=TRUE)
clams.coll <- appendColumn(clams.coll, "dark", TRUE, 
                           start.str="06:00:00 PM", stop.str="06:00:00 AM", is.daily=TRUE)

clams.coll <- adjustMeasurement(clams.coll, "VO2")

clams.msr <- alignMeasurement(clams.coll, "ADJ.VO2", c("LIGHT", "DARK", "TEMP.30", "TEMP.22", "TEMP.4"))

plotMeasurement(clams.msr, "Oxygen Consumption, ml/kg/hr", "VO2-TEST.pdf",
                agg.names=list(c("TEST.WT.A1", "TEST.WT.A3", "TEST.WT.A5"), c("TEST.WT.B1", "TEST.WT.B3", "TEST.WT.B5"), c("TEST.C.2", "JH619", "TEST.C.6")),
                agg.labels=c("A", "B", "C"),
                con.names=c("TEMP.30", "TEMP.22", "TEMP.4"),
                con.labels=expression(paste("30", degree, "C"), paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter="x", do.error.bars=FALSE, legend.coord="bottomright")

clams.msr <- alignMeasurement(clams.coll, "HEAT", c("LIGHT", "DARK", "TEMP.30", "TEMP.22", "TEMP.4"))

plotMeasurement(clams.msr, "HEAT, kcal/hour", "HEAT-TEST.pdf",
                agg.names=list(c("TEST.WT.A1", "TEST.WT.A3", "TEST.WT.A5"), c("TEST.WT.B1", "TEST.WT.B5"), c("TEST.C.2", "JH619")),
                agg.labels=c("A", "B", "C"),
                con.names=c("TEMP.30", "TEMP.22", "TEMP.4"),
                con.labels=expression(paste("30", degree, "C"), paste("22", degree, "C"), paste("4", degree, "C")),
                do.filter="x", do.error.bars=FALSE, legend.coord="bottomright")







