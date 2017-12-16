## Draw plot3.png

## Rough Estimate of memory requirements
## 2,075,259 observations
## 9 variables: 2 character strings and 7 numeric
## each numeric and 1 character string (time) takes 8 bytes each. 
## 1 character  string (date) takes 10 bytes
## So, each row, needs 8*8+10 = 74 bytes
## Full DS needs 2,075,259 * 74, which is around 150MB

## Please run only if you have 150MB RAm availabe

## read data
initial <- read.table("household_power_consumption.txt", nrows=100, header = TRUE, check.names = FALSE, sep=";")
classes <- sapply(initial, class)

rm(initial)
tabAll <- read.table(
            "household_power_consumption.txt", 
            header=T, 
            colClasses = classes, 
            na.strings = "?", 
            nrows = 2075259, 
            comment.char = "",
            check.names = FALSE,
            sep=";")

tabFiltered <- subset(tabAll, Date=="1/2/2007" | Date=="2/2/2007")
rm(tabAll)
tabFiltered <- mutate(tabFiltered, 
                      datetime=as.POSIXct(paste(tabFiltered[,1], tabFiltered[,2], sep = " "), 
                                         format = "%d/%m/%Y %H:%M:%S"))

## Draw plot 2
## size defaults to width = 480, height = 480, units = "px", which meets the requirements
png(filename = "plot3.png")

with(tabFiltered,plot(datetime,Sub_metering_1 , type = "l", xlab="", ylab="Energy sub metering"))
with(tabFiltered,lines(datetime,Sub_metering_2, col="red"))
with(tabFiltered,lines(datetime,Sub_metering_3, col="blue"))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       pch="_____", col=c("black", "red", "blue"))

dev.off()


