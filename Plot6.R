# 6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

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

# subsetting the data to compare Baltimore city and LA for the plot
LAplot <- subset(mergeData, (fips == "24510" | fips == "06037") & type =="ON-ROAD", c("Emissions", "Year","type", "fips"))

LAplot <- rename(LAplot, c("fips"="City"))

# reorganize the data for the plot 
LAplot <- melt(LAplot, id=c("Year", "City"), measure.vars=c("Emissions"))

# Sum up the data by City and then by Year
LAplot <- dcast(LAplot, City + Year ~ variable, sum)

# find the differences in emissions
LAplot[2:8,"Change"] <- diff(LAplot$Emissions)

# where there is no data for 1998, initialize it to 0 for each city
LAplot[c(1,5),4] <- 0

# Plot the graph using ggplot
ggplot(data=LAplot, aes(x=Year, y=Change, group=City, color=City)) + geom_line() + geom_point( size=2, shape=15, fill="red") + xlab("Year") + ylab("Change in Emissions (tons)") + ggtitle("Motor Vehicle PM2.5 Emissions Changes: Baltimore vs. LA")

# save the image as a png file
ggsave(file="Plot6.png")

