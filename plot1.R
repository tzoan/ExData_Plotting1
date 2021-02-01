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



##plot1.R
png("plot1.png",width=480, height=480)
hist(powercon$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()



