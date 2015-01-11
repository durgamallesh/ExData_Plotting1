plot1 <- function(){
  fileurl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

  temp <- tempfile()
  download.file(fileurl,temp,method="curl")
  unzip(temp,exdir="./")

  hcd <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

  hcd_m <- mutate(hcd,date_1 = strptime(hcd$Date,"%d/%m/%Y"))

  hcd_r <- hcd_m[hcd_m$date_1 %in% c("2007-02-01","2007-02-02"),]
  
  par(mar=c(4,4,1,1),mfrow=c(1,1))

  hist(hcd_r$Global_active_power)

  hist(hcd_r$Global_active_power,col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)",cex.lab=0.75,cex.axis=0.75)

  dev.copy(png,filename="plot1.png",width=480,height=480)

  dev.off()

}