#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#Read Data
# setwd("~/R/ExploratoryDataAnalysis/Assignment 2")

# DOwnload the file
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="Data.zip")

# Unzip the data into a folder
unzip("Data.zip",exdir = "./DataFiles")


# Read the two source files from the downloaded zip file
SourceData <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

# Create year wise totals from the emissions data
yearsTotal <- unique(emissionsData$year)

#Store the emission Data for the city of Baltimore
BEmissions <- emissionsData[emissionsData$fips=="24510",]

# Find totals for the city of Baltimore
TotalBaltimoreByYear<- tapply(BEmissions$Emissions,BEmissions$year,sum)

# set to store the plot into a png file
png(filename ='Plot2.png')

# plot the graph for total emissions in the city of Baltimore
plot(TotalBaltimoreByYear,type="l",xaxt ="n",xlab = "Year",ylab="Total Emissions",main = "Total Emissions in the Baltimore")

#set axis for the plot
axis(side=1,labels=as.character(yearsTotal),at=1:length(yearsTotal))

# save the plot as png image
dev.copy(png,'Plot2.png')
dev.off()