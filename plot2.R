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
png(filename = "plot2.png",width = 480, height = 480)

# Creating plot 2
plot(data$Timestamp, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")
  
dev.off()
