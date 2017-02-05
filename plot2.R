# read data
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#subset data of Baltimore City
y1 <- subset(NEI,fips == "24510")
s2 <- aggregate(Emissions ~ year,y1, sum)

#plot
barplot(s2$Emissions,names.arg = s2$year,xlab = "Year",ylab = "Total PM2.5 emission")
title(main = "Total Emission In Baltimore City ")
#save file
dev.copy(png, file = "plot2.png")
dev.off()
         
