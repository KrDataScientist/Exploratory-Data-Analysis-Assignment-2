# 1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read Data
#setwd("~/R/ExploratoryDataAnalysis/Assignment 2")

#DOwnload the file
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="Data.zip")

#Unzip the data into a folder
unzip("Data.zip",exdir = "./DataFiles")

## Read the two source files from the downloaded zip file
SourceData <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## View the data loaded from the summarySCC_PM25.rds
str(emissionsData)

## Create year wise totals from the emissions data
yearsTotal <- unique(emissionsData$year)

## Total the emissions by year into TotalByYear
totalByYear <- tapply(emissionsData$Emissions,emissionsData$year,sum)

## Plot the graph with the x axis showing the years and the y-axis showing the total emissions
plot(totalByYear,type="l",xaxt ="n",xlab = "Year",ylab="Total Emissions",main = 
       "Total Emissions in the U.S")

## Assign the labels
axis(side=1,labels=as.character(yearsTotal),at=1:length(yearsTotal))

# save the plot
dev.copy(png,'Plot1.png')
dev.off()