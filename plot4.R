##
## Purpose: 
##  Create 4 plots to look like plot4.png to analyse Global Active Power, 
##  Voltage, Energy Sub Metering and Global reactive power on Feb 1, 2007 to 
##  30 Mar 2007.
##
## Parameters:
##  N/A
##
## Example of usage:
##  Locate household_power_consumption.txt in the working directory. 
##  Run the script here which will output a plot diagram in PNG format.
##
## Author: 
##  20150606 - Julie Koesmarno (http://www.mssqlgirl.com)
##



## Ensure we start new plot


plot.new()

## Load sqldf package, for read.csv.sql
if (!(is.element("sqldf", installed.packages()[,1])))
{
  
  print ("Installing sqldf")
  install.packages("sqldf")
}
library("sqldf")


## Only retrieve the data for Feb 1 - 2, 2007 from household_power_consumption.txt
t <- read.csv.sql(file = "household_power_consumption.txt", 
                  sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                  header = TRUE,
                  sep = ";",
                  eol = "\n")

summary(t)

## Add a new column called DateTime
t$DateTime <- paste(t$Date, t$Time)

## Convert it to the proper date time format
t$DateTime <- strptime(x = t$DateTime, format = "%d/%m/%Y %H:%M:%S")

op <- par(no.readonly = TRUE)
frame()
plot.new()

## Plot 4
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

par(mfrow=c(2,2)) #, oma = c(2,2,0,0)))

## Chart 1
plot(t$DateTime, t$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", cex.lab = 0.75, cex.axis = 0.75)

## Chart 2
plot(t$DateTime, t$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", cex.lab = 0.75, cex.axis = 0.75)

## Chart 3
plot(t$DateTime, t$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", cex.lab = 0.75, cex.axis = 0.75)
lines(t$DateTime, t$Sub_metering_2, col = "red")
lines(t$DateTime, t$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = 1:3, lwd = 1, cex = 0.7, bty = "n")

## Chart 4
plot(t$DateTime, t$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", cex.lab = 0.75, cex.axis = 0.75)
par(op)
dev.off()


