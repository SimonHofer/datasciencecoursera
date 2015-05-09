df <- read.csv("household_power_consumption.txt", sep=";")
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df2 <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
df2$Sub_metering_1 <- as.numeric(as.character(df2$Sub_metering_1))
df2$Sub_metering_2 <- as.numeric(as.character(df2$Sub_metering_2))
df2$Sub_metering_3 <- as.numeric(as.character(df2$Sub_metering_3))

png("plot3.png")

plot(df2$Sub_metering_1 ~ as.POSIXct(paste(df2$Date,df2$Time)),
     type="l", xlab="", ylab="Energy sub metering")
lines(df2$Sub_metering_2 ~ as.POSIXct(paste(df2$Date,df2$Time)),
      type="l", col="red")
lines(df2$Sub_metering_3 ~ as.POSIXct(paste(df2$Date,df2$Time)),
      type="l", col="blue")
legend("topright", pch= "_", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()