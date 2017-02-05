# read data
library(ggplot2)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
#find sources of coal
coal_sources <- SCC[grepl(pattern = "coal", x = SCC$Short.Name, 
                     ignore.case = TRUE), ]
#merge NEI and coal_sources
coal_NEI <- merge(x = NEI, y = coal_sources, by = 'SCC')



s4 <- aggregate(Emissions ~ year, coal_NEI, sum)


attach(s4)


# make a barplot
g <- ggplot(s4, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity") + 
  xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
  ggtitle('Total Emissions from Coal Sources Changed from 1999 to 2008')

print(g)


# Save file
dev.copy(png, file = "plot4.png")
dev.off()