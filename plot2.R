library(data.table)

##load the data
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")
powercon<-read.table("./getcleandata/household_power_consumption.txt",header=T,sep=';',na.strings="?")


##using data from the dates 2007-02-01 and 2007-02-02
powercon<-powercon[which(powercon$Date=="1/2/2007"|powercon$Date == "2/2/2007"),]
powercon$Date<- as.Date(powercon$Date, format="%d/%m/%Y")



##plot2.R
powercon$Date <- as.Date(powercon$Date,"%d/%m/%Y")
powercon<-cbind(powercon, "DateTime" = as.POSIXct(paste(powercon$Date,powercon$Time)))
Sys.setlocale(category = "LC_ALL", locale = "english")
png("plot2.png",width=480, height=480)
plot(powercon$Global_active_power~powercon$DateTime, type="l", xlab= "", ylab="Global Active power (kilowatts)")
dev.off()
