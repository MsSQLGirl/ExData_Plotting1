
##
## Purpose: 
##  Create a plot to look like plot3.png to display Energy Sub Metering
##  for 1 Feb 2007 to 2 Feb 2007
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

## Add a new column called DateTime
t$DateTime <- paste(t$Date, t$Time)

## Convert it to the proper date time format
t$DateTime <- strptime(x = t$DateTime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")


## Plot 3
plot(t$DateTime, t$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(t$DateTime, t$Sub_metering_2, col = "red")
lines(t$DateTime, t$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = 1:3, lwd = 1)

dev.off()