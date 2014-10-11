
## Read full DataSet (Might take a while)
DSFull <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
DSFull$Date <- as.Date(DSFull$Date, format="%d/%m/%Y")

## Subsetting required data and removing full DS
rdata <- subset(DSFull, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(DSFull)

## Converting dates to POSIX
datetime <- paste(as.Date(rdata$Date), rdata$Time)
rdata$Datetime <- as.POSIXct(datetime)

png("plot3.png",width=480,height=480) 

# Plot 3
with(rdata, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()