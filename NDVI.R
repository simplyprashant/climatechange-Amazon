############ NDVI ##############################

library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting
library(tidyverse)

#Loading netCDF files for NDVI for the period 2010 to 2022
nc_1 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/AVHRR-Land_v005_AVH13C1_NOAA-19_20100601_c20170406132557.nc')
nc_2 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/AVHRR-Land_v005_AVH13C1_NOAA-19_20110601_c20170407034511.nc')
nc_3 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/AVHRR-Land_v005_AVH13C1_NOAA-19_20120601_c20170407155136.nc')
nc_4 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/AVHRR-Land_v005_AVH13C1_NOAA-19_20130601_c20170408061931.nc')
nc_5 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20140601_c20220416004656.nc')
nc_6 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20150601_c20220416162532.nc')
nc_7 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20160601_c20220417102702.nc')
nc_8 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20170601_c20220417202948.nc')
nc_9 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20180601_c20220418070417.nc')
nc_10 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20190601_c20220418173848.nc')
nc_11 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20200601_c20220419043235.nc')
nc_12 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20210601_c20220419150743.nc')
nc_13 <- nc_open('C:/Users/prash/Desktop/Project/NDVI/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20220601_c20220606124456.nc')

#Printing metadata file
{
sink('nc_1 metadata.txt')
  print(nc_1)
  sink()
}

#Extracting the longitude from nc file
lon_1 <- ncvar_get(nc_1, "longitude")
lon_2 <- ncvar_get(nc_2, "longitude")
lon_3 <- ncvar_get(nc_3, "longitude")
lon_4 <- ncvar_get(nc_4, "longitude")
lon_5 <- ncvar_get(nc_5, "longitude")
lon_6 <- ncvar_get(nc_6, "longitude")
lon_7 <- ncvar_get(nc_7, "longitude")
lon_8 <- ncvar_get(nc_8, "longitude")
lon_9 <- ncvar_get(nc_9, "longitude")
lon_10 <- ncvar_get(nc_10, "longitude")
lon_11 <- ncvar_get(nc_11, "longitude")
lon_12 <- ncvar_get(nc_12, "longitude")
lon_13 <- ncvar_get(nc_13, "longitude")

#Extracting the latitude from the nc file
lat_1 <- ncvar_get(nc_1, "latitude")
lat_2 <- ncvar_get(nc_2, "latitude")
lat_3 <- ncvar_get(nc_3, "latitude")
lat_4 <- ncvar_get(nc_4, "latitude")
lat_5 <- ncvar_get(nc_5, "latitude")
lat_6 <- ncvar_get(nc_6, "latitude")
lat_7 <- ncvar_get(nc_7, "latitude")
lat_8 <- ncvar_get(nc_8, "latitude")
lat_9 <- ncvar_get(nc_9, "latitude")
lat_10 <- ncvar_get(nc_10, "latitude")
lat_11 <- ncvar_get(nc_11, "latitude")
lat_12 <- ncvar_get(nc_12, "latitude")
lat_13 <- ncvar_get(nc_13, "latitude")

#Extracting time dimension from the nc file
t_1 <- ncvar_get(nc_1, "time")
t_2 <- ncvar_get(nc_2, "time")
t_3 <- ncvar_get(nc_3, "time")
t_4 <- ncvar_get(nc_4, "time")
t_5 <- ncvar_get(nc_5, "time")
t_6 <- ncvar_get(nc_6, "time")
t_7 <- ncvar_get(nc_7, "time")
t_8 <- ncvar_get(nc_8, "time")
t_9 <- ncvar_get(nc_9, "time")
t_10 <- ncvar_get(nc_10, "time")
t_11 <- ncvar_get(nc_11, "time")
t_12 <- ncvar_get(nc_12, "time")
t_13 <- ncvar_get(nc_13, "time")

#Extracting the required NDVI variable from nc file
ndvi_1 <- ncvar_get(nc_1, "NDVI")
ndvi_2 <- ncvar_get(nc_2, "NDVI")
ndvi_3 <- ncvar_get(nc_3, "NDVI")
ndvi_4 <- ncvar_get(nc_4, "NDVI")
ndvi_5 <- ncvar_get(nc_5, "NDVI")
ndvi_6 <- ncvar_get(nc_6, "NDVI")
ndvi_7 <- ncvar_get(nc_7, "NDVI")
ndvi_8 <- ncvar_get(nc_8, "NDVI")
ndvi_9 <- ncvar_get(nc_9, "NDVI")
ndvi_10 <- ncvar_get(nc_10, "NDVI")
ndvi_11 <- ncvar_get(nc_11, "NDVI")
ndvi_12 <- ncvar_get(nc_12, "NDVI")
ndvi_13 <- ncvar_get(nc_13, "NDVI")

#Checking the fill value which is the missing value 
fillvalue_1 <- ncatt_get(nc_1, "NDVI", "_FillValue")
fillvalue_2 <- ncatt_get(nc_2, "NDVI", "_FillValue")
fillvalue_3 <- ncatt_get(nc_3, "NDVI", "_FillValue")
fillvalue_4 <- ncatt_get(nc_4, "NDVI", "_FillValue")
fillvalue_5 <- ncatt_get(nc_5, "NDVI", "_FillValue")
fillvalue_6 <- ncatt_get(nc_6, "NDVI", "_FillValue")
fillvalue_7 <- ncatt_get(nc_7, "NDVI", "_FillValue")
fillvalue_8 <- ncatt_get(nc_8, "NDVI", "_FillValue")
fillvalue_9 <- ncatt_get(nc_9, "NDVI", "_FillValue")
fillvalue_10 <- ncatt_get(nc_10, "NDVI", "_FillValue")
fillvalue_11 <- ncatt_get(nc_11, "NDVI", "_FillValue")
fillvalue_12 <- ncatt_get(nc_12, "NDVI", "_FillValue")
fillvalue_13 <- ncatt_get(nc_13, "NDVI", "_FillValue")

#Closing the netCDF files as the data extraction is complete
nc_close(nc_1)
nc_close(nc_2)
nc_close(nc_3)
nc_close(nc_4)
nc_close(nc_5)
nc_close(nc_6)
nc_close(nc_7)
nc_close(nc_8)
nc_close(nc_9)
nc_close(nc_10)
nc_close(nc_11)
nc_close(nc_12)
nc_close(nc_13)

#Replacing the missing values with NA as the standard
ndvi_1[ndvi_1 == fillvalue_1$value] <- NA
ndvi_2[ndvi_2 == fillvalue_2$value] <- NA
ndvi_3[ndvi_3 == fillvalue_3$value] <- NA
ndvi_4[ndvi_4 == fillvalue_4$value] <- NA
ndvi_5[ndvi_5 == fillvalue_5$value] <- NA
ndvi_6[ndvi_6 == fillvalue_6$value] <- NA
ndvi_7[ndvi_7 == fillvalue_7$value] <- NA
ndvi_8[ndvi_8 == fillvalue_8$value] <- NA
ndvi_9[ndvi_9 == fillvalue_9$value] <- NA
ndvi_10[ndvi_10 == fillvalue_10$value] <- NA
ndvi_11[ndvi_11 == fillvalue_11$value] <- NA
ndvi_12[ndvi_12 == fillvalue_12$value] <- NA
ndvi_13[ndvi_13 == fillvalue_13$value] <- NA

#Converting NDVI variable (2010) into a raster brick
r_1 <- raster(t(ndvi_1), xmn=min(lon_1), xmx=max(lon_1), ymn=min(lat_1), ymx=max(lat_1),
              crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

plot(r_1)
plot(r_1, xlim = c(-100,-30), ylim = c(-20,10))


#Converting NDVI (2022) into a raster brick
r_13 <- raster(t(ndvi_13), xmn=min(lon_13), xmx=max(lon_13), ymn=min(lat_13), ymx=max(lat_13),
              crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
plot(r_13)
plot(r_13, xlim = c(-100,-30), ylim = c(-20,10))


#Difference in NDVI between 2010 and 2022
ndvi.diff <- ndvi_13 - ndvi_1
r_diff <- raster(t(ndvi.diff), xmn=min(lon_1),
                 xmx=max(lon_1), ymn=min(lat_1), ymx=max(lat_1), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

#Plotting the results
plot(r_diff, xlim = c(-100,-30), ylim = c(-20,10))
title(main = "Difference in NDVI between 2010 and 2022",
      xlab = "Longitude", ylab = "Latitude",
      cex.main = 2,   font.main= 4, col.main= "red",
      cex.sub = 0.75, font.sub = 3, col.sub = "green",
      col.lab ="darkblue"
)

#COnverting NDVI(2014-2016) into raster to check changes during 
# El-Nino phase

#2014
r_5 <- raster(t(ndvi_5), xmn=min(lon_5), xmx=max(lon_5), ymn=min(lat_5), ymx=max(lat_5),
              crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))


#2015
r_6 <- raster(t(ndvi_6), xmn=min(lon_6), xmx=max(lon_6), ymn=min(lat_6), ymx=max(lat_6),
               crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

#2016
r_7 <- raster(t(ndvi_7), xmn=min(lon_7), xmx=max(lon_7), ymn=min(lat_7), ymx=max(lat_7),
              crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

#NDVI - June 2014
par(mfrow = c(1,3))
plot(r_5, xlim = c(-100,-30), ylim = c(-30,10))
title(main = "Spatial variation of NDVI in June 2014",
      xlab = "Longitude", ylab = "Latitude",
      cex.main = 1,   font.main= 2, col.main= "Black",
      cex.sub = 0.75, font.sub = 3, col.sub = "green",
      col.lab ="darkblue"
)

#NDVI - June 2015
plot(r_6, xlim = c(-100,-30), ylim = c(-30,10))
title(main = "Spatial variation of NDVI in June 2015",
      xlab = "Longitude", ylab = "Latitude",
      cex.main = 1,   font.main= 2, col.main= "Black",
      cex.sub = 0.75, font.sub = 3, col.sub = "green",
      col.lab ="darkblue"
)

#NDVI - June 2016
plot(r_7, xlim = c(-100,-30), ylim = c(-30,10))
title(main = "Spatial variation of NDVI in June 2016",
      xlab = "Longitude", ylab = "Latitude",
      cex.main = 1,   font.main= 2, col.main= "Black",
      cex.sub = 0.75, font.sub = 3, col.sub = "green",
      col.lab ="darkblue")

#Difference in NDVI during 2014-2016 El Nino period
ndvi.nino <- ndvi_7 - ndvi_5
r_nino <- raster(t(ndvi.nino), xmn=min(lon_5),
                 xmx=max(lon_5), ymn=min(lat_5), ymx=max(lat_5), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

plot(r_nino, xlim = c(-100,-30), ylim = c(-20,10))
title(main = "Difference in NDVI during the El-Nino period (2014-2016)",
      xlab = "Longitude", ylab = "Latitude",
      cex.main = 2,   font.main= 4, col.main= "red",
      cex.sub = 0.75, font.sub = 3, col.sub = "green",
      col.lab ="darkblue"
)

#Creating time series for NDVI at 4 different locations in the Amazon basin
#site 1 (-2.27, -62.325)
#site 2 (0.02, -61.5)
#site 3 (-5.5, -64.5)
#site 4 (-5.5, -70.5)

#NDVI values for the period 2010 - 2022 at 4 sites
NDVI1 <- c(ndvi_1[2355,1846],ndvi_2[2355,1846],ndvi_3[2355,1846],ndvi_4[2355,1846],
               ndvi_5[2355,1846],ndvi_6[2355,1846],ndvi_7[2355,1846],ndvi_8[2355,1846],
               ndvi_9[2355,1846],ndvi_10[2355,1846],ndvi_11[2355,1846],ndvi_12[2355,1846],
               ndvi_13[2355,1846])

NDVI2 <- c(ndvi_1[2370,1800],ndvi_2[2370,1800],ndvi_3[2370,1800],ndvi_4[2370,1800],
           ndvi_5[2370,1800],ndvi_6[2370,1800],ndvi_7[2370,1800],ndvi_8[2370,1800],
           ndvi_9[2370,1800],ndvi_10[2370,1800],ndvi_11[2370,1800],ndvi_12[2370,1800],
           ndvi_13[2370,1800])

NDVI3 <- c(ndvi_1[2310,1911],ndvi_2[2310,1911],ndvi_3[2310,1911],ndvi_4[2310,1911],
           ndvi_5[2310,1911],ndvi_6[2310,1911],ndvi_7[2310,1911],ndvi_8[2310,1911],
           ndvi_9[2310,1911],ndvi_10[2310,1911],ndvi_11[2310,1911],ndvi_12[2310,1911],
           ndvi_13[2310,1911])

NDVI4 <- c(ndvi_1[2190,1911],ndvi_2[2190,1911],ndvi_3[2190,1911],ndvi_4[2190,1911],
          ndvi_5[2190,1911],ndvi_6[2190,1911],ndvi_7[2190,1911],ndvi_8[2190,1911],
           ndvi_9[2190,1911],ndvi_10[2190,1911],ndvi_11[2190,1911],ndvi_12[2190,1911],
           ndvi_13[2190,1911])

#Creating a data frame
ts <- data.frame(year = seq(from=2010, to=2022, by=1), Loc1 = NDVI1,
                 Loc2 = NDVI2, Loc3 = NDVI3, Loc4 = NDVI4)

#creating a plot of NDVI variation
ggplot(ts, aes(x=year, group =1)) +
  geom_line(aes(y = Loc1), color = "black") +
  geom_line(aes(y = Loc2), color = "steelblue", linetype = "twodash") +
  geom_line(aes(y = Loc3), color = "green", linetype = "twodash") +
  geom_line(aes(y = Loc4), color = "yellow", linetype = "twodash") +
  ggtitle("Growing season NDVI at 4 different locations in the Amazon basin")      # Set title

