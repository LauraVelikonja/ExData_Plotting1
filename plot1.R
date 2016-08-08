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

# Export to png
png(filename = "plot1.png",width = 480, height = 480)

# Plot 1
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main ="Global Active Power")

dev.off()
