# download and extract the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- tempfile()
downloadDir <- "./coursera_4/ExData_Plotting1"
download.file(url, file, method = "curl") 
dataDir <- paste(downloadDir,"/Household_Power_Consumption", sep="")
if(!file.exists(dataDir)) { unzip(file, exdir = dataDir) }
list.files(downloadDir)
list.dirs(dataDir, full.names = TRUE, recursive = TRUE)

#read data from household_power_consumption.txt
#We will only be using data from the dates 2007-02-01 and 2007-02-02.
#One alternative is to read the data from just those dates rather than 
#reading in the entire dataset and subsetting to those dates.

cls <- c(Voltage="numeric", Global_active_power="numeric",Global_intensity="numeric",
         Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric",
         Global_active_power="numeric",Global_reactive_power="numeric")

data <- read.table("./coursera_4/ExData_Plotting1/Household_Power_Consumption/household_power_consumption.txt", 
                   header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=cls)

energyData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#interpret data correctly
as.Date(energyData$Date)

#delete all rows with NA values
energyData <-na.omit(energyData)
png(file  = "./coursera_4/ExData_Plotting1/plot1.png")
#plot data
hist(energyData$Global_active_power, col="red",xlab="Global Active Power (kilowatts)",
     ylab="Frequency",main="Global Active Power")

dev.off()

