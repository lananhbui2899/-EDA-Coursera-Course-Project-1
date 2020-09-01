library(lubridate)
library(tidyverse)
df1 <- read.delim("household_power_consumption.txt", header=T, sep = ";",dec = ".")
str(df1)
names(df1)
df1[c("Date")] <- df1[c("Date")] %>% mutate(Date= dmy(Date)) %>% mutate_at(vars(Date), funs(year, month, day))
df1[c("Time")] <- df1[c("Time")] %>% mutate(Time= hms(Time))
df1[,3:8] <- lapply(df1[,3:8],as.numeric)
str(df1)
head(df1)
df2 <- df1 %>% 
  filter(between(Date,as.Date("2007-02-01"),as.Date("2007-02-02"))) 
df2 <- df2 %>% 
  mutate_at(vars(Date), funs(year, month, day)) %>% 
  mutate_at(vars(Time), funs(hour,minute,second)) 
df2 <- df2 %>% mutate(Datetime=make_datetime(year,month,day,hour,minute,second))
str(df2)

plot(df2$Datetime,df2$Sub_metering_1,type="l", xlab = " ", ylab = "Energy Sub Metering")
lines(df2$Datetime,df2$Sub_metering_3,type="l",col="blue")
lines(df2$Datetime,df2$Sub_metering_2,type="l",col="red")
legend("topright", col = c("black", "red","blue"), 
       legend = c("Sub_metering_1  ", "Sub_metering_2  ","Sub_metering_3  "),
       lty=1, cex=0.7, box.lwd = 1)

png("plot2.png", width=480, height = 480, units ="px" )