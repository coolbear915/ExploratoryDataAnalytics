# Load and clean data
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?"); df <- na.omit(df)

# Convert Date column to proper Date objects
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

#  Subset by weekday
day_names <- weekdays(df$Date); Thu <- df[day_names=="Thursday", ]; Fri <- df[day_names=="Friday", ]; Sat <- df[day_names=="Saturday", ]

# Concatenate values
x_all <- c(Thu$Date, Fri$Date, Sat$Date)
y_active <- c(Thu$Global_active_power, Fri$Global_active_power, Sat$Global_active_power)
y1_all <- c(Thu$Sub_metering_1, Fri$Sub_metering_1, Sat$Sub_metering_1)
y2_all <- c(Thu$Sub_metering_2, Fri$Sub_metering_2, Sat$Sub_metering_2)
y3_all <- c(Thu$Sub_metering_3, Fri$Sub_metering_3, Sat$Sub_metering_3)
y_volt <- c(Thu$Voltage, Fri$Voltage, Sat$Voltage)
y_react <- c(Thu$Global_reactive_power, Fri$Global_reactive_power, Sat$Global_reactive_power)

# PNG 1: Histogram 
hist(df$Global_active_power, col="red", breaks=22, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
png("plot1_histogram.png", width=480, height=480); hist(df$Global_active_power, col="red", breaks=22, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power"); dev.off()

# PNG 2: Global Active Power line 
plot(x_all, y_active, type="l", col="black", xlab="Weekday", ylab="Global Active Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
png("plot2_global_active.png", width=480, height=480); plot(x_all, y_active, type="l", col="black", xlab="Weekday", ylab="Global Active Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday")); dev.off()

# PNG 3: Sub-metering 
plot(x_all, y1_all, type="l", col="black", xlab="Weekday", ylab="Energy sub metering", xaxt="n"); lines(x_all, y2_all, col="red"); lines(x_all, y3_all, col="blue"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday")); legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
png("plot3_submetering.png", width=480, height=480); plot(x_all, y1_all, type="l", col="black", xlab="Weekday", ylab="Energy sub metering", xaxt="n"); lines(x_all, y2_all, col="red"); lines(x_all, y3_all, col="blue"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday")); legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1); dev.off()

#  PNG 4: Combined 2x2 layout 
par(mfrow=c(2,2))
plot(x_all, y_active, type="l", col="black", xlab="Weekday", ylab="Global Active Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
plot(x_all, y1_all, type="l", col="black", xlab="Weekday", ylab="Energy sub metering", xaxt="n"); lines(x_all, y2_all, col="red"); lines(x_all, y3_all, col="blue"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday")); legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
plot(x_all, y_volt, type="l", col="black", xlab="Weekday", ylab="Voltage", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
plot(x_all, y_react, type="l", col="black", xlab="Weekday", ylab="Global Reactive Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))

png("plot4_combined.png", width=960, height=960); par(mfrow=c(2,2))
plot(x_all, y_active, type="l", col="black", xlab="Weekday", ylab="Global Active Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
plot(x_all, y1_all, type="l", col="black", xlab="Weekday", ylab="Energy sub metering", xaxt="n"); lines(x_all, y2_all, col="red"); lines(x_all, y3_all, col="blue"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday")); legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
plot(x_all, y_volt, type="l", col="black", xlab="Weekday", ylab="Voltage", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
plot(x_all, y_react, type="l", col="black", xlab="Weekday", ylab="Global Reactive Power (kilowatts)", xaxt="n"); axis(1, at=c(min(Thu$Date), min(Fri$Date), min(Sat$Date)), labels=c("Thursday","Friday","Saturday"))
dev.off()
