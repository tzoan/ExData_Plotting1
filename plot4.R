library(data.table)

##load the data
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")
powercon<-read.table("./getcleandata/household_power_consumption.txt",header=T,sep=';',na.strings="?")


##using data from the dates 2007-02-01 and 2007-02-02
powercon<-powercon[which(powercon$Date=="1/2/2007"|powercon$Date == "2/2/2007"),]




##plot4.R
powercon$Date <- as.Date(powercon$Date,"%d/%m/%Y")
powercon<-cbind(powercon, "DateTime" = as.POSIXct(paste(powercon$Date,powercon$Time)))
Sys.setlocale(category = "LC_ALL", locale = "english")
png("plot4.png",width=480, height=480)
par(mfrow=c(2,2))
with(powercon,plot(powercon$DateTime,powercon$Global_active_power,type="l", xlab= "", ylab="Global Active power (kilowatts)"))
with(powercon,plot(powercon$DateTime,powercon$Voltage,type="l",xlab= "datetime", ylab="Voltage"))
with(powercon, {plot(Sub_metering_1 ~ DateTime, type="l", xlab= "", ylab="Energy Sub Metering")})
lines(powercon$Sub_metering_2 ~ powercon$DateTime, col = 'Red')
lines(powercon$Sub_metering_3 ~ powercon$DateTime, col = 'Blue')
legend("topright", lty=1, lwd =3, col=c("black","red","blue") ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(powercon,plot(powercon$DateTime,powercon$Global_reactive_power,type="l",xlab= "datetime", ylab="Global reactive power"))
dev.off()


