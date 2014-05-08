###--------------------------------------------------------------
###  plot4.R:
###     Creates a plot with 4 plots: 
###          Global active power
###          Voltage
###          house hold Sub_Metering 1-3
###          Global reactive power
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

## SETUP 2X2 PLOT
par(mfrow = c(2,2))

## ADJUST TEXT SIZES FOR LABELS
par(cex = .83) 
par(cex.axis = .7)
par(cex.lab = .7)


### Plot1: Global Active power, placement: Row=1 Col=1
plot(plot_data$POSIX, plot_data$Global_active_power, 
     type='l',
     col='black',
     ylab="Global Active Power",
     xlab=NA
)


### Plot2: Voltage, placement: Row=1 Col=2
plot(plot_data$POSIX, plot_data$Voltage, 
     type='l',
     col='black',
     ylab="Voltage",
     xlab="datetime"
)


### Plot: Submetering, placement: Row=2 Col=1
plot(plot_data$POSIX, plot_data$Sub_metering_1, 
     type='n',
     ylab="Energy sub metering",
     xlab=NA
     )
lines(plot_data$POSIX, plot_data$Sub_metering_1, col='black')
lines(plot_data$POSIX, plot_data$Sub_metering_2, col='red')
lines(plot_data$POSIX, plot_data$Sub_metering_3, col='blue')
legend(as.POSIXct("2007-02-01 17:00:00"), 39, 
       lty=c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=.8,
       bty='n',
       seg.len=4)
       
### Plot4: Global reactive power, placement: Row=2 Col=2
plot(plot_data$POSIX, plot_data$Global_reactive_power, 
     type='l',
     col='black',
     ylab="Global_reactive_power",
     xlab="datetime"
)

dev.copy(png, filename='plot4.png', width = 480, height = 480)

dev.off()

