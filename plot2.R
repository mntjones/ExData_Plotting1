# download file based on date section from downloaded file in directory
energyData <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                         header = FALSE, sep = ";", stringsAsFactors = FALSE)

# add column names
colnames(energyData) <- c("Date", "Time", "Global_Active_Power_(kW)", "Global_Reactive_Power_(kW)", 
                          "Voltage_(V)", "Global_Intensity_(A)", "Kitchen_Energy_(W-hr)", 
                          "Laundry_Energy_(W-hr)", "WaterHeater_AC_Energy_(W-hr)")

# subset and remove NAs
energy_sub <- subset(energyData, select = c("Date", "Time", "Global_Active_Power_(kW)"))
energy_sub[ energy_sub == "?" ] = NA
NAlist <- complete.cases(energy_sub)
energy_clean <- energy_sub[NAlist,]

# Combines date and time, turns it into a date object
date_and_time <- paste(energy_clean$Date, " ", energy_clean$Time)
dateTimeFormat <- strptime(date_and_time, format="%d/%m/%Y  %H:%M:%S", tz = "GMT")

# launch graphics device
png("plot2.png")

# create plot of data- Day (in day of week format) vs. Global Active Power
plot(dateTimeFormat, energy_clean$'Global_Active_Power_(kW)', ylab = "Global Active Power (kilowatts)", 
     t = "l")

# close device
dev.off()