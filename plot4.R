# download and extract the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- tempfile()
downloadDir <- "./coursera_4/ExData_Plotting1"
download.file(url, file, method = "curl") 
dataDir <- paste(downloadDir,"/Household_Power_Consumption", sep="")
if(!file.exists(dataDir)) { unzip(file, exdir = dataDir) }
list.files(downloadDir)
list.dirs(dataDir, full.names = TRUE, recursive = TRUE)

library(dplyr)
loadData <- function() {
  read.table("./coursera_4/ExData_Plotting1/Household_Power_Consumption/household_power_consumption.txt",
             sep=';', header=TRUE) %>%
    mutate(Date = as.Date(Date, '%d/%m/%Y')) %>%
    mutate(Time = as.POSIXct(strptime(paste(Date, ' ', Time), '%Y-%m-%d %H:%M:%S'))) %>%
    filter(Time >= strftime('2007-02-01 00:00:00'), Time < strftime('2007-02-03 00:00:00')) %>%
    tbl_df
}

data <- loadData()

png(filename="./coursera_4/ExData_Plotting1/plot4.png", width=480, height=480, units='px')

par(mfrow=c(2,2))

startDay = as.POSIXct(strftime("2007-02-01 00:00:00"))
endDay = as.POSIXct(strftime("2007-02-03 00:00:00"))

plot(data$Time,
     data$Global_active_power,
     xlim=c(startDay, endDay),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Global Active Power"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

plot(data$Time,
     data$Voltage,
     xlim=c(startDay, endDay),
     xaxt="n",
     type="l",
     xlab="datetime",
     ylab="Voltage"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

#delete all rows with NA values
data <-na.omit(data)

plot(data$Time,
     data$Sub_metering_1,
     xlim=c(startDay, endDay),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Energy sub metering"
)

lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")

axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

legend("topright", 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=c(1, 1, 1))

plot(data$Time,
     data$Global_reactive_power,
     xlim=c(startDay, endDay),
     xaxt="n",
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

dev.off()


