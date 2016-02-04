
# Exploratory Data Analysis - Quiz 1
# Author: j6a
# Date: 2/2/16
# R-code to generate plot4.png

# Download the dataset if it doesnt already existin in the working directory

if(!file.exists("./exdata-data-household_power_consumption.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,"./exdata-data-household_power_consumption.zip")
  unzip("./exdata-data-household_power_consumption.zip")
}

# Read the the data for 1/2/2007  - 2/2/2007 into memory

DF <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                 na.strings = "?",
                 colClasses = c("character","character", rep("numeric",times=7)), nrows = 2880 , skip = 66636)

#Convert the Data and Time character fields into a POSIXlt variable
DF$datetime <- strptime(paste(DF$Date, DF$Time), format = "%d/%m/%Y %H:%M:%S")

# Replace date and time strinds with datetime type
DF <- DF[,c("datetime", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

# Plot to png file in working directory
png(filename = "plot4.png", width = 480, height = 480)

# Make plot
par(mfcol = c(2,2), mar = c(4,4,3,1), oma = c(1,1,1,1))

#Topleft
plot(DF$datetime,DF$Global_active_power, type = "n", main = NULL, xlab = "", ylab = "Global Active Power" )
lines(DF$datetime,DF$Global_active_power)
#Bottom Left
plot(DF$datetime,DF$Global_active_power, type = "n", main = NULL, xlab = "", ylab = "Energy sub metering", ylim = c(0,38) )
lines(DF$datetime,DF$Sub_metering_1)
lines(DF$datetime,DF$Sub_metering_2, col="red")
lines(DF$datetime,DF$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"), bty = "n", y.intersp = 1, cex = 0.8)
#top right
plot(DF$datetime,DF$Voltage, type = "n", main = NULL, xlab = "datetime", ylab = "Voltage" )
lines(DF$datetime,DF$Voltage)
#bottom right
plot(DF$datetime,DF$Global_reactive_power, type = "n", main = NULL, xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0,0.51))
lines(DF$datetime,DF$Global_reactive_power)



# Close PNG device
dev.off()