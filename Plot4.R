# 4.Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#install the necessary library
library(plyr)
library(ggplot2)

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

# subsetting the short names required for the plot
CoalPlot <- subset(mergeData, grepl('Coal',mergeData$Short.Name, fixed=TRUE), c("Emissions", "Year","type", "Short.Name"))

#Aggregate the data for Emissions by Year
CoalPlot <- aggregate(Emissions ~ Year, CoalPlot, sum)

# Plot the graph using ggplot
ggplot(data=CoalPlot, aes(x=Year, y=Emissions)) + geom_line() + geom_point( size=4, shape=15, fill="red") + xlab("Year") + ylab("Emissions (thousands of tons)") + ggtitle("Total United States PM2.5 Coal Emissions")

# export the plot as a png image
dev.copy(png,'Plot4.png')
dev.off()
