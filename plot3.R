# download file based on date section from downloaded file in directory

energyData <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                         header = FALSE, sep = ";", stringsAsFactors = FALSE)

# add column names
colnames(energyData) <- c("Date", "Time", "Global_Active_Power_(kW)", "Global_Reactive_Power_(kW)", 
                          "Voltage_(V)", "Global_Intensity_(A)", "Sub_metering_1", 
                          "Sub_metering_2", "Sub_metering_3")

# subset and make sure data is in the correct class
energy_sub <- subset(energyData, select = c("Date", "Time", "Sub_metering_1", "Sub_metering_2",
                                            "Sub_metering_3"))

as.numeric(as.character(energy_sub$Sub_metering_1))
as.numeric(as.character(energy_sub$Sub_metering_2))
as.numeric(as.character(energy_sub$Sub_metering_3))

# Combines date and time, turns it into a date object
date_and_time <- paste(energy_sub$Date, " ", energy_sub$Time)
dateTimeFormat <- strptime(date_and_time, format="%d/%m/%Y  %H:%M:%S", tz = "GMT")

# launch graphics device (.png)
png("plot3.png")

# Plot graph
plot(dateTimeFormat, energy_sub$Sub_metering_1, ylab = "Energy sub metering", xlab = "",
    t = "l")
# adds red and blue lines
lines(dateTimeFormat, energy_sub$Sub_metering_2, t = "l", col = "red")
lines(dateTimeFormat, energy_sub$Sub_metering_3, t = "l", col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))

# Device off
dev.off()
