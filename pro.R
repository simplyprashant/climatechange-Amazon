library(ggplot2) # package for plotting
library(readxl) #Working with excel files
library(tidyverse)
library(stringr)

#Setting the working directory
setwd("C:/Users/prash/Desktop/Project")

##### Multivariate ENSO index
#Reading in the ENSO data
mei <- read_excel("ENSO Index.xlsx")

#Data Wrangling
mei_lon <- gather(mei, months, MEI, DJ:ND, factor_key = TRUE)

#Arranging in ascending order
mei_lon <- mei_lon[order(mei_lon$YEAR), ]

#Converting year to factor
mei_lon$YEAR <- as.factor(mei_lon$YEAR)

#Creating a copy dataset
smei_lon <- mei_lon

#Changing months to character
smei_lon$months <- as.character(smei_lon$months)

#Alloting months a sequence character eg: December-January as 1
smei_lon$months[smei_lon$months == 'DJ'] <- '01'
smei_lon$months[smei_lon$months == 'JF'] <- "02"
smei_lon$months[smei_lon$months == 'FM'] <- "03"
smei_lon$months[smei_lon$months == 'MA'] <- '04'
smei_lon$months[smei_lon$months == 'AM'] <- '05'
smei_lon$months[smei_lon$months == 'MJ'] <- '06'
smei_lon$months[smei_lon$months == 'JJ'] <- '07'
smei_lon$months[smei_lon$months == 'JA'] <- '08'
smei_lon$months[smei_lon$months == 'AS'] <- '09'
smei_lon$months[smei_lon$months == 'SO'] <- '10'
smei_lon$months[smei_lon$months == 'ON'] <- '11'
smei_lon$months[smei_lon$months == 'ND'] <- '12'

#Creating date format
smei_lon$Time <- str_c(smei_lon$YEAR,'-',smei_lon$months)
smei_lon$Time <- str_c(smei_lon$Time, '-01')

#Changing data type from character to date
smei_lon$Time <- as.Date(smei_lon$Time)

#Plotting MEI values
ggplot(smei_lon, aes(x=Time, y=MEI)) +
  geom_area() +
  labs(title = 'Multivariate ENSO Index (1979-2022)',
       x = 'Year',
       y = 'ENSO Index')

#Filter data for color fill
upr <- smei_lon %>% 
  filter(MEI >= 0)

lwr <- smei_lon %>% 
  filter(MEI < 0)

#Plotting final MEI plot
ggplot(smei_lon, aes(x=Time, y=MEI)) +
  geom_col(data = lwr, fill = 'blue') +
  geom_col(data = upr, fill = 'red') +
  geom_hline(yintercept=2, linetype="dashed", color = "black")+
  geom_hline(yintercept=-2, linetype="dashed", color = "black")+
  labs(title = 'Multivariate ENSO Index (1979-2022)',
       x = 'Year',
       y = 'ENSO Index')


