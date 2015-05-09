df <- read.csv("household_power_consumption.txt", sep=";")
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df2 <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
df2$Global_active_power <- as.numeric(as.character(df2$Global_active_power))

png("plot2.png")
plot(df2$Global_active_power ~ as.POSIXct(paste(df2$Date,df2$Time)),
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
