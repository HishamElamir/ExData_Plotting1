
setwd('/home/he-lab/Documents/r_projects/')

library(ggplot2)
library(dplyr)
library(grid)
library(gridExtra)



data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_file <- "./data/exdata_data_household_power_consumption.zip"

if(!dir.exists("./data")){
  dir.create("./data")
}
download.file(data_url, destfile=data_file)

data <- read.table(unz(data_file, "household_power_consumption.txt"), header=T, sep=";")
subset_of_data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

## ANALYSIS ONE
global_active_power <- as.numeric(subset_of_data$Global_active_power)

## ANALYSIS TWO
datetime <- strptime(paste(subset_of_data$Date, subset_of_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## ANALYSIS THREE
sub_metering_1 <- as.numeric(subset_of_data$Sub_metering_1)
sub_metering_2 <- as.numeric(subset_of_data$Sub_metering_2)
sub_metering_3 <- as.numeric(subset_of_data$Sub_metering_3)

## ANALYSIS FOUR
global_reactive_power <- as.numeric(subset_of_data$Global_reactive_power)
voltage <- as.numeric(subset_of_data$Voltage)

## PLOT ONE
png("plot1.png", width=480, height=480)
hist(global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

## PLOT TWO
png("plot2.png", width=480, height=480)
plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## PLOT THREE
png("plot3.png", width=480, height=480)
plot(datetime, sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_metering_2, type="l", col="red")
lines(datetime, sub_metering_3, type="l", col="blue")
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

## PLOT FOUR
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_metering_2, type="l", col="red")
lines(datetime, sub_metering_3, type="l", col="blue")
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()













