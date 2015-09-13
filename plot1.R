# download file based on date section from downloaded file in directory

energyData <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                         header = FALSE, sep = ";")

# add column names
colnames(energyData) <- c("Date", "Time", "Global_Active_Power_(kW)", "Global_Reactive_Power_(kW)", 
                          "Voltage_(V)", "Global_Intensity_(A)", "Kitchen_Energy_(W-hr)", 
                          "Laundry_Energy_(W-hr)", "WaterHeater_AC_Energy_(W-hr)")

# launch graphics device (.png)
png("plot1.png")

# create plot of data- Global Active Power (kilowatts) vs. Frequency with Title = Global Active Power
# breaks is how many pieces to break the data into, cex changes the size of the various texts.

hist(energyData$`Global_Active_Power_(kW)`, breaks = 12, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", freq = TRUE, col = "red")

# close graphics device
dev.off()
