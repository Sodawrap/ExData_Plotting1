
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

png("plot2.png",width=480,height=480) 

## Create plot
plot(data$Global_active_power~rdata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.off()