###--------------------------------------------------------------
###  plot3.R:
###     Creates a plot of house hold Sub_Metering 1-3
###
###  Date          By           Notes
###  2014-05-07   saoconnell    Initial development
###--------------------------------------------------------------

## CLEANUP THE WORK SPACE
rm(list=ls())

###  SET THE WORKING DIRECTORY
setwd("~/Documents/workspace/coursera/Data_Science/Exploratory_Data_Analysis/assignment_one/ExData_Plotting1")

### READ IN DATA
in_data <- read.csv("household_power_consumption.txt", sep=';', header=TRUE, stringsAsFactors=FALSE)

## CONVERT COLUMNS TO NUMERIC (WARNING IS '?' ARE COERCED TO NA)
in_data$Global_active_power <- as.numeric(in_data$Global_active_power)
in_data$Sub_metering_1 <- as.numeric(in_data$Sub_metering_1)
in_data$Sub_metering_2 <- as.numeric(in_data$Sub_metering_2)

## CREATE A POSIX DATE FOR SUBSETTING
in_data$POSIX <- as.POSIXct(strptime(paste(in_data$Date, in_data$Time), format="%d/%m/%Y %H:%M:%S"))


### SUBSET DATA 
plot_data <- subset(in_data, POSIX >= as.POSIXct("2007-02-01") & POSIX < as.POSIXct("2007-02-03") )
summary(plot_data)

### PLOT DATA

png("plot3.png", width = 480, height = 480)

plot(plot_data$POSIX, plot_data$Sub_metering_1, 
     type='n',
     ylab="Energy sub metering",
     xlab=NA
     )
lines(plot_data$POSIX, plot_data$Sub_metering_1, col='black')
lines(plot_data$POSIX, plot_data$Sub_metering_2, col='red')
lines(plot_data$POSIX, plot_data$Sub_metering_3, col='blue')
legend("topright", 
       lty=c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
