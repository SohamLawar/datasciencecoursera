library(ggplot2)
library(plyr)
# read data
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
#subset data of Baltimore City 
y2 <- subset(NEI,fips == "24510" , remove.na  = T)
s3 <- aggregate(Emissions ~ year+type,y2, sum)

attach(s3)
year = as.character(year)
type = as.factor(type)
#plot
g <- ggplot(s3, aes(factor(year), Emissions))
g <- g + geom_bar(aes(fill = type), stat = "identity") + facet_grid(. ~ type) + 
  xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')

print(g)

# Save file
dev.copy(png, file = "plot3.png")
dev.off()