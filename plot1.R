# read data
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
#sum of PM2.5 per year
s1 <- aggregate(Emissions ~ year,NEI, sum)
#plot
barplot(s1$Emissions,names.arg = s1$year,xlab = "Year",ylab = "Total PM2.5 emission")
#save file
dev.copy(png, file = "plot1.png")
dev.off()