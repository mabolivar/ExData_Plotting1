#===============================================
# Working directory
#===============================================
setwd("C:\\Users\\Manuel\\Dropbox\\3. DSS\\ExData_Plotting1")
#===============================================

#install.packages("lubridate")
library(lubridate)

#Number of lines to be readed
x<-dmy_hms("16/12/2006 17:24:00") #First date in the fie
y<-dmy_hms("01/02/2007 00:00:00") #First date
z<-dmy_hms("02/02/2007 23:59:59") #Last date

lrow <- ceiling(difftime(z,x,units="mins"))+1
frow <- ceiling(difftime(y,x,units="mins"))+2

con <- file("./data/household_power_consumption.txt")
lines <- readLines(con,lrow)
names <- lines[1]
lines <- lines[frow:lrow]
close(con)

#From string vector to data frame
epc <- data.frame(do.call("rbind",strsplit(lines,";",fixed = T)),stringsAsFactors = F)
epc[,2] <- dmy_hms(paste(epc[,1],epc[,2]))
epc[,1] <- dmy(epc[,1])
epc[,3:9] <- mapply(as.numeric,epc[3:9])
names(epc) <- unlist(strsplit(names,";")) #column names
#str(epc)

#Figure 2
png(filename = "./figure/plot2.png",width = 480, height = 480, units="px",bg = "transparent")
plot(epc$Time,epc$Global_active_power,type = "l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

