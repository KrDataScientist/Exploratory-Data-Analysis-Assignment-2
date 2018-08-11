# 3.Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#install the necessary library
library(plyr)
library(ggplot2)

#Read Data
# setwd("~/R/ExploratoryDataAnalysis/Assignment 2")

# Download the file
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
AggByYear <- aggregate(BEmissions$Emissions, list(BEmissions$type, BEmissions$year),mean)

# set to store the plot into a png file
png(filename ='Plot3.png')

#Create the ggplot
thePlot <- ggplot(agg_type_year, aes(y=x, x=Group.2))+geom_point(aes(colour = factor(Group.1)), size = 2)

#Set the colors and grouping for the factors
thePlot+geom_line(aes(group=Group.1,colour=Group.1))

# export the plot as a png image
dev.copy(png,'Plot3.png')
dev.off()