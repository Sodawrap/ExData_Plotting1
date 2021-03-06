
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

png("plot4.png",width=480,height=480) 

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(rdata, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.off()