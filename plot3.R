plot3 <- function(){
  fileurl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

  temp <- tempfile()
  download.file(fileurl,temp,method="curl")
  unzip(temp,exdir="./")

  hcd <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

  hcd_m <- mutate(hcd,date_1 = strptime(hcd$Date,"%d/%m/%Y"))

  hcd_r <- hcd_m[hcd_m$date_1 %in% c("2007-02-01","2007-02-02"),]
  
  hcd_r <- mutate(hcd_r,dateTime=paste(Date,Time))
  
  hcd_r <- mutate(hcd_r,dateTime_1=strptime(hcd_r$dateTime,"%d/%m/%Y %H:%M:%S"))
  
  hcd_r$dateTime <- NULL
  par(mar=c(4,4,1,1),mfrow=c(1,1))
  
  plot(hcd_r$dateTime_1, hcd_r$Sub_metering_1,type="n", ylab="Energy sub metering",xlab="",cex.lab=0.75,cex.axis=0.75)
  lines(hcd_r$dateTime_1,hcd_r$Sub_metering_1,col="black")
  lines(hcd_r$dateTime_1,hcd_r$Sub_metering_2,col="red")
  lines(hcd_r$dateTime_1,hcd_r$Sub_metering_3,col="blue")
  
  legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lwd=1,cex=0.7)
  
  dev.copy(png,filename="plot3.png",width=480,height=480)

  dev.off()

}