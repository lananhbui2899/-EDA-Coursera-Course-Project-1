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
plot(df2$Datetime,df2$Global_active_power,type = "l", 
     xlab = " ", ylab = "Global Active Power (kilowatts)")
png("plot2.png", width=480, height = 480, units ="px" )