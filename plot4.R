# Download data -----------------------------------------------------------

# Check if already have data directory and download the data project
if(!file.exists("data")){dir.create("data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Eletric.zip",
              method = "curl")
list.files("./data")
unzip("./data/Eletric.zip", exdir = getwd())


# Read and adjust data---------------------------------------------------------------

library(dplyr)
library(stringr)

#Read data
data = read.csv2("./household_power_consumption.txt", colClasses = "character")
str(data)

#Select the rows 
start_data = row.names(head(data[data$Date == "1/2/2007",],1))
end_data = row.names(tail(data[data$Date == "2/2/2007",],1))
data_sub = data[c(start_data:end_data),]

#Combine data columns
data_sub$date_time = paste(data_sub$Date, data_sub$Time) 
data_sub$date_time = strptime(data_sub$date_time, "%d/%m/%Y %H:%M:%S")

#Character to numeric
data_sub$Global_active_power = as.numeric(data_sub$Global_active_power)
data_sub$Global_reactive_power = as.numeric(data_sub$Global_reactive_power)
data_sub$Voltage = as.numeric(data_sub$Voltage)
data_sub$Global_intensity = as.numeric(data_sub$Global_intensity)
data_sub$Sub_metering_1 = as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 = as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 = as.numeric(data_sub$Sub_metering_3)
str(data_sub)



# Plot_a ------------------------------------------------------------------

plot(data_sub$date_time, data_sub$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")


# Plot_b ------------------------------------------------------------------

plot(data_sub$date_time, data_sub$Voltage,
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage")


# Plot_c -------------------------------------------------------------------

plot(data_sub$date_time, data_sub$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = 1)
lines(data_sub$date_time, data_sub$Sub_metering_2,
      type = "l",
      col = "red")
lines(data_sub$date_time, data_sub$Sub_metering_3,
      type = "l",
      col = "blue")


# Plot_d ------------------------------------------------------------------

plot(data_sub$date_time, data_sub$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")


# Plot_4 --------------------------------------------------------------

par(mfrow = c(2,2))

plot(data_sub$date_time, data_sub$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(data_sub$date_time, data_sub$Voltage,
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage")

plot(data_sub$date_time, data_sub$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = 1)
lines(data_sub$date_time, data_sub$Sub_metering_2,
      type = "l",
      col = "red")
lines(data_sub$date_time, data_sub$Sub_metering_3,
      type = "l",
      col = "blue")

plot(data_sub$date_time, data_sub$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# Save image to png -------------------------------------------------------

png("plot4.png", height = 480, width = 480)

par(mfrow = c(2,2))

plot(data_sub$date_time, data_sub$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(data_sub$date_time, data_sub$Voltage,
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage")

plot(data_sub$date_time, data_sub$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = 1)
lines(data_sub$date_time, data_sub$Sub_metering_2,
      type = "l",
      col = "red")
lines(data_sub$date_time, data_sub$Sub_metering_3,
      type = "l",
      col = "blue")

plot(data_sub$date_time, data_sub$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()