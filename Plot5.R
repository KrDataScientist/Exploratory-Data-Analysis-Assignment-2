# Question - 5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


#install the necessary library
library(plyr)
library(ggplot2)
library(reshape2)

#Read Data
# setwd("~/R/ExploratoryDataAnalysis/Assignment 2")

# DOwnload the file
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="Data.zip")

# Unzip the data into a folder
unzip("Data.zip",exdir = "./DataFiles")


# Read the two source files from the downloaded zip file
SourceData <- readRDS("Source_Classification_Code.rds") (SCC)
emissionsData <- readRDS("summarySCC_PM25.rds") (NEI)

#Subset the Names from the Source classification code
ds <- subset(SourceData, select = c("SCC", "Short.Name"))

#merge the emissionsData with the subset of short names from the Source classification
mergeData <- merge(emissionsData, ds, by.x="SCC", by.y="SCC", all=TRUE)

#Calculate the Emissions from the merged data
mergeData$Emissions <- mergeData$Emissions/1000


#Rename the header for Year
mergeData <- rename(mergeData, c("year"="Year"))

# subsetting the motor vehicle sources for the year range for Baltimore city required for the plot
motorvehiclePlot <- subset(mergeData, fips == "24510" & type =="ON-ROAD", c("Emissions", "Year","type"))

#Aggregate the data for Emissions by Year
motorvehiclePlot <- aggregate(Emissions ~ Year, motorvehiclePlot, sum)

# Plot the graph using ggplot
ggplot(data=motorvehiclePlot, aes(x=Year, y=Emissions)) + geom_line() + geom_point( size=2, shape=15, fill="red") + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")

#