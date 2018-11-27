#loading libraries 
library(raster)
library('maptools')
library('sp')

ukraine <- getData('GADM', country='UKR', level=1)  
save(ukraine,file="C:\\Users\\Дмитро\\Desktop\\R\\ukrmap.Rdata")   
load(ukraine)  

setwd("C:\\Users\\Дмитро\\Desktop\\R\\")
dat<-read.csv("geoMap.csv",header=T,stringsAsFactors = F)   #reading files with data about our requests on each region
nams<-read.csv("ukrna.csv",header=T)

datn<-merge(nams,dat,by="Region",all=T)
newreal <- as.numeric(sub("%", "",datn$real,fixed=TRUE))/100   #converting percents in decimal points
newbarca <- as.numeric(sub("%", "",datn$barca,fixed=TRUE))/100   #converting percents in decimal points
x<-newbarca/(newbarca+newreal)   #find ratio one request to other requests

numcol<-7   #amount of colours on a map
brkMP<-c(min(x)-0.001,seq(min(x)+0.001,max(x)+0.001,length.out=numcol+1))   #interval`s limits of values x, which displayed the same colour
intMP<-numcol+2-findInterval(x,brkMP)   #define which color will image certain regions 

palette(c(heat.colors(numcol, alpha = 1),rgb(1,1,1)))   #set up colors palette
par(xpd=TRUE)   #allow to draw on bourders
par(mar=c(0,0,0,0))   #set up zero size of bourders  
plot(ukraine,col=intMP[order(datn$n)])   #plot map
legend("bottomright",title="Barcelona",legend=c("<45","<38","<31","<24","<18","<12","<6","0"),fill=c(heat.colors(numcol, alpha = 1),rgb(1,1,1)),inset=0,horiz = F)
#set up an explanatory legend
