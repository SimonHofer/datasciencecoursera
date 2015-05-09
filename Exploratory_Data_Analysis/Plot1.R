df <- read.csv("household_power_consumption.txt", sep=";")
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df2 <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
df2$Global_active_power <- as.numeric(as.character(df2$Global_active_power))

png("plot1.png")
hist(df2$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
png("plot1.png")
dev.off()