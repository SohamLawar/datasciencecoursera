library(ggplot2)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
#subset data of Baltimore City & type ON-ROAD
y6_1 <- subset(NEI,fips == "24510" & type == "ON-ROAD" , remove.na  = T)
#subset data of LA & type ON-ROAD
y6_2 <- subset(NEI,fips == "06037" & type == "ON-ROAD" , remove.na  = T)
#sum of emission per year
s6_1 <- aggregate(Emissions ~ year,y6_1, sum)
s6_2 <- aggregate(Emissions ~ year, y6_2,sum)

s6 <- rbind(s6_1,s6_2)
s6 <- cbind(s6,region = c(rep("Bal", 4), rep("LA", 4)))

attach(s6)

g <- ggplot(s6, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity", aes(fill = factor(year))) + 
  xlab("year") + ylab(expression('total PM'[2.5]*" emission"))+
  facet_grid(. ~ region)

print(g)
# Save file
dev.copy(png, file = "plot6.png")
dev.off()