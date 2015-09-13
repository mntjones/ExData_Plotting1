# download file based on date section from downloaded file in directory

energyData <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                         header = FALSE, sep = ";", stringsAsFactors = FALSE)

# add column names
colnames(energyData) <- c("Date", "Time", "Global_Active_Power_(kW)", "Global_Reactive_Power_(kW)", 
                          "Voltage_(V)", "Global_Intensity_(A)", "Sub_metering_1", 
                          "Sub_metering_2", "Sub_metering_3")

# Since the assignment calls for each graph to be fully reproducible within the R code, I
# will be copying code used in the previous sections for a couple of these graphs

# Upper left = Plot2

energy_plot2 <- subset(energyData, select = c("Date", "Time", "Global_Active_Power_(kW)"))
energy_plot2[ energy_plot2 == "?" ] = NA
NAlist <- complete.cases(energy_plot2)
energy_clean2 <- energy_plot2[NAlist,]

# Combines date and time, turns it into a date object - used for all four graphs
date_and_time <- paste(energy_clean2$Date, " ", energy_clean2$Time)
dateTimeFormat <- strptime(date_and_time, format="%d/%m/%Y  %H:%M:%S", tz = "GMT")

# Lower left = plot3
energy_plot3 <- subset(energyData, select = c("Date", "Time", "Sub_metering_1", "Sub_metering_2",
                                            "Sub_metering_3"))

as.numeric(as.character(energy_plot3$Sub_metering_1))
as.numeric(as.character(energy_plot3$Sub_metering_2))
as.numeric(as.character(energy_plot3$Sub_metering_3))

# Upper Right
energy_plot4 <- subset(energyData, select = c("Date", "Time", "Voltage_(V)"))
energy_plot4[ energy_plot4 == "?" ] = NA
NAlist <- complete.cases(energy_plot4)
energy_clean4 <- energy_plot4[NAlist,]

#Lower Right
energy_plot5 <- subset(energyData, select = c("Date", "Time", "Global_Reactive_Power_(kW)"))
energy_plot5[ energy_plot5 == "?" ] = NA
NAlist <- complete.cases(energy_plot5)
energy_clean5 <- energy_plot5[NAlist,]

# Plot in quadrants
png("plot4.png")
#sets up parameters of graph 
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
#plots out the four different graphs L->R, T->B
with (energyData, {
  plot(dateTimeFormat, energy_clean2$'Global_Active_Power_(kW)', ylab = "Global Active Power", 
                  t = "l", xlab = "")
  
  plot(dateTimeFormat, energy_clean4$'Voltage_(V)', ylab = "Voltage", 
       t = "l", xlab = "datetime")
  
  plot(dateTimeFormat, energy_sub$Sub_metering_1, ylab = "Energy sub metering", xlab = "",
       t = "l")
  lines(dateTimeFormat, energy_sub$Sub_metering_2, t = "l", col = "red")
  lines(dateTimeFormat, energy_sub$Sub_metering_3, t = "l", col = "blue")
  
  legend("topright", lty = 1, col = c("black", "red", "blue"), 
         legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), cex = 0.7, bty = "n")
  
  plot(dateTimeFormat, energy_clean5$'Global_Reactive_Power_(kW)', ylab = "Global_reactive_power", 
     t = "l", xlab = "datetime")
})
# close device
dev.off()