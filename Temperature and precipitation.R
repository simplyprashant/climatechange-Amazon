library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting
library(gridExtra)

#Loading the precipitation netcdf file
prec <- nc_open("C:/Users/prash/Desktop/Project/Tempprec/timeseries-pr-annual-mean_era_annual_era5-0.5x0.5-timeseries_mean_1950-2020.nc")

#Printing metadata file
{
  sink('Precipitation metadata.txt')
  print(prec)
  sink()
}

#Extracting the longitude, latitude and the year dimensions
plon <- ncvar_get(prec, "lon")
plat <- ncvar_get(prec, "lat")
pyear <- ncvar_get(prec, "year")

#Extracting the precipitation variable

ppt <- ncvar_get(prec, "timeseries-pr-annual-mean")
dim(ppt) #Verifying the dimension with the metadata table

#Checking the fill value which is the missing value 
fillval <- ncatt_get(prec, "timeseries-pr-annual-mean", "_FillValue")
fillval

#Close the nc file
nc_close(prec)

#Replacing the missing values with NA as the standard
ppt[ppt == fillval$value] <- NA

#Extracting the precipitation values for 20 year period(2000-2020) at the above
#mentioned site 1,2,3 and 4  
#Site 1: (-2.25,-62.25)
#Site 2: (-5.25,-64.25)
#Site 3: (-5.25,-70.25)
#Site 4: (-5.25,-61.75)

#creating empty vectors
Prec1 = c()
Prec2 = c()
Prec3 = c()
Prec4 = c()

#Appending precipitation values for the years 2010-2020 
#61 refers to the year number in the period 1950-2020 (i.e. 2010)
for(j in 61:71){
  ppt1 <- ppt[236,176,j]
  ppt2 <- ppt[232,170,j]
  ppt3 <- ppt[220,170,j]
  ppt4 <- ppt[237,170,j]
  Prec1 <- append(Prec1,ppt1)
  Prec2 <- append(Prec2,ppt2)
  Prec3 <- append(Prec3,ppt3)
  Prec4 <- append(Prec4,ppt4)
}

#Data frame of the precipitation values
pts <- data.frame(year = 2010:2020, Site_1 = Prec1, Site_2 = Prec2,
                  Site_3 = Prec3, Site_4 = Prec4)

#Plots for the 4 sites
st1 <- ggplot(pts, aes(x=as.factor(year), y=Site_1, group=1)) +
  geom_point()+
  geom_line() +
  geom_smooth(se=F)+
  geom_tile(aes(x = as.factor(2015), y=2800), height = 1000,width = 2, alpha = 0.05,fill = 'grey50')+
  labs(x = "Year", y = "Precipitation (in mm)")+
  ggtitle("Precipitation trend at Site 1")      # Set title

st2 <- ggplot(pts, aes(x=as.factor(year), y=Site_2,group=1)) +
  geom_point()+
  geom_line() +
  geom_smooth(se=F)+
  geom_tile(aes(x = as.factor(2015), y=2800), height = 1000,width = 2, alpha = 0.05,fill = 'grey50')+
  labs(x = "Year", y = "Precipitation (in mm)")+
  ggtitle("Precipitation trend at Site 2")      # Set title

st3 <- ggplot(pts, aes(x=as.factor(year), y=Site_3, group=1)) +
  geom_point()+
  geom_line() +
  geom_smooth(se=F)+
  geom_tile(aes(x = as.factor(2015), y=2800), height = 1000,width = 2, alpha = 0.05,fill = 'grey50')+
  labs(x = "Year", y = "Precipitation (in mm)")+
  ggtitle("Precipitation trend at Site 3")      # Set title

st4 <- ggplot(pts, aes(x=as.factor(year), y=Site_4, group=1)) +
  geom_point()+
  geom_line() +
  geom_smooth(method = 'loess', se = F)+
  geom_tile(aes(x = as.factor(2015), y=2800), height = 1000,width = 2, alpha = 0.05,fill = 'grey50')+
  labs(x = "Year", y = "Precipitation (in mm)")+
  ggtitle("Precipitation trend at Site 4")      # Set title

#Arranging the grid of plots
grid.arrange(st1,st2,st3,st4, ncol = 2, nrow = 2)


##############################################
#Temperature data

#loading temperature nc file
temp <- nc_open("C:/Users/prash/Desktop/Project/Tempprec/timeseries-tas-annual-mean_era_annual_era5-0.5x0.5-timeseries_mean_1950-2020.nc")

#Printing metadata file
{
  sink('temperature metadata.txt')
  print(temp)
  sink()
}

#Extracting the longitude, latitude and the year dimensions
tlon <- ncvar_get(temp, "lon")
tlat <- ncvar_get(temp, "lat")
tyear <- ncvar_get(temp, "year")

#Extracting the temperature variable

tt <- ncvar_get(temp, "timeseries-tas-annual-mean")
dim(tt)

#Checking the fill value which is the missing value   
fillval_t <- ncatt_get(temp, "timeseries-tas-annual-mean", "_FillValue")
fillval_t

#Close the nc file
nc_close(temp)

#Replacing the missing values with NA as the standard
tt[tt == fillval_t$value] <- NA

#Extracting the temperature values for 20 year period(2000-2020) at the below
#mentioned site 1,2,3 and 4  
#Site 1: (-2.25,-62.25)
#Site 2: (-5.25,-64.25)
#Site 3: (-5.25,-70.25)
#Site 4: (-5.25,-61.75)

temp1 = c()
temp2 = c()
temp3 = c()
temp4 = c()
for(i in 61:71){
  t1 <- tt[236,176,i]
  t2 <- tt[232,170,i]
  t3 <- tt[220,170,i]
  t4 <- tt[237,170,i]
  temp1 <- append(temp1,t1)
  temp2 <- append(temp2,t2)
  temp3 <- append(temp3,t3)
  temp4 <- append(temp4,t4)
}

#Data frame of the temperature values
temps <- data.frame(year = 2010:2020, te_1 = temp1, te_2 = temp2,
                  te_3 = temp3, te_4 = temp4)

#Plots
T1 <- ggplot(temps, aes(x=as.factor(year), y=te_1, group=1)) +
  geom_line() +
  geom_point()+
  geom_smooth(level=0.99, color = 'red')+
  labs(x = "Year", y = 'Temperature (in Celcius)')+
  ggtitle("Temperature trend at Site 1 ")      # Set title

T2 <- ggplot(temps, aes(x=as.factor(year), y=te_2,group=1)) +
  geom_line() +
  geom_point()+
  geom_smooth(level=0.99, color = 'red')+
  labs(x = "Year", y = 'Temperature (in Celcius)')+
  ggtitle("Temperature trend at Site 2 ")      # Set title

T3 <- ggplot(temps, aes(x=as.factor(year), y=te_3, group=1)) +
  geom_line() +
  geom_point()+
  geom_smooth(level=0.99, color = 'red')+
  labs(x = "Year", y = 'Temperature (in Celcius)')+
  ggtitle("Temperature trend at Site 3 ")      # Set title

T4 <- ggplot(temps, aes(x=as.factor(year), y=te_4, group=1)) +
  geom_line() +
  geom_point()+
  geom_smooth(level=0.99, color = 'red')+
  labs(x = "Year", y = 'Temperature (in Celcius)')+
  ggtitle("Temperature trend at Site 4")      # Set title

grid.arrange(T1,T2,T3,T4, ncol = 2, nrow = 2)

