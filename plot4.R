# Set directory
setwd("...")

# Read in data
library(data.table)
data <- fread("household_power_consumption.txt")

# Replace ? with NA values
data[data=="?"] <- NA

data <- data.frame(data)

# Convert data and time to Data/Time classes
data$Timestamp = strptime(paste(data$Date, data$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Only use data from Day 2007-02-01 and 2007-02-02
data <- subset(data, Date == "2007-02-01"| Date == "2007-02-02")

# Convert characters to numeric values
for (i in (3:dim(data)[2]-1)){
data[,i] <- as.numeric(data[,i])
}

#data <- cbind(data,weekdays.Date(data$Date))
#names(data)[10] <- "Weekday"

# Export to png
png(filename = "plot4.png",width = 480, height = 480)

# Creating plot 4

# Setting grid
par(mfrow = c(2,2))

# plot1
plot(data$Timestamp, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")
# plot2
plot(data$Timestamp, data$Voltage, type = "l", ylab = "Voltage", xlab ="datetime")
# plot3
plot(data$Timestamp, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab ="")
lines(data$Timestamp,data$Sub_metering_2, col = "red")
lines(data$Timestamp,data$Sub_metering_3, col = "blue")
legend(x=max(data$Timestamp)-90000,y=max(data$Sub_metering_1)+1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col = c("black","red","blue"), lty = c(1,1,1), cex=0.7, bty ="n")
#plot4
plot(data$Timestamp, data$Global_active_power, ylab = "Global_active_power",type = "l", xlab ="datetime")

dev.off()
