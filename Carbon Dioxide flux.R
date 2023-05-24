library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting

#Reading in the nc files for carbon flux
nc_cd1 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200012.nc")
nc_cd2 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200112.nc")
nc_cd3 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200212.nc")
nc_cd4 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200312.nc")
nc_cd5 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200412.nc")
nc_cd6 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200512.nc")
nc_cd7 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200612.nc")
nc_cd8 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200712.nc")
nc_cd9 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200812.nc")
nc_cd10 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/200912.nc")
nc_cd11 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201012.nc")
nc_cd12 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201112.nc")
nc_cd13 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201212.nc")
nc_cd14 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201312.nc")
nc_cd15 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201412.nc")
nc_cd16 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201512.nc")
nc_cd17 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201612.nc")
nc_cd18 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201712.nc")
nc_cd19 <- nc_open("C:/Users/prash/Desktop/Project/Carbon flux/201812.nc")

#Printing metadata file
{
  sink('nc_cd1 metadata.txt')
  print(nc_cd1)
  sink()
}

#Extracting longitude 

cd1_lon <- ncvar_get(nc_cd1, "longitude")



#Extracting latitude
cd1_lat <- ncvar_get(nc_cd1, "latitude")

#Extracting Posterior land surface upward mass flux of carbon for the whole grid
# box and the whole month without fossil

cd1_cf <- ncvar_get(nc_cd1, "flux_apos_bio")
cd2_cf <- ncvar_get(nc_cd2, "flux_apos_bio")
cd3_cf <- ncvar_get(nc_cd3, "flux_apos_bio")
cd4_cf <- ncvar_get(nc_cd4, "flux_apos_bio")
cd5_cf <- ncvar_get(nc_cd5, "flux_apos_bio")
cd6_cf <- ncvar_get(nc_cd6, "flux_apos_bio")
cd7_cf <- ncvar_get(nc_cd7, "flux_apos_bio")
cd8_cf <- ncvar_get(nc_cd8, "flux_apos_bio")
cd9_cf <- ncvar_get(nc_cd9, "flux_apos_bio")
cd10_cf <- ncvar_get(nc_cd10, "flux_apos_bio")
cd11_cf <- ncvar_get(nc_cd11, "flux_apos_bio")
cd12_cf <- ncvar_get(nc_cd12, "flux_apos_bio")
cd13_cf <- ncvar_get(nc_cd13, "flux_apos_bio")
cd14_cf <- ncvar_get(nc_cd14, "flux_apos_bio")
cd15_cf <- ncvar_get(nc_cd15, "flux_apos_bio")
cd16_cf <- ncvar_get(nc_cd16, "flux_apos_bio")
cd17_cf <- ncvar_get(nc_cd17, "flux_apos_bio")
cd18_cf <- ncvar_get(nc_cd18, "flux_apos_bio")
cd19_cf <- ncvar_get(nc_cd19, "flux_apos_bio")

#Check for fill value for the missing values
miss <- ncatt_get(nc_cd1, "flux_apos_bio", "_FillValue")
miss

#close nc file
nc_close(nc_cd1)
nc_close(nc_cd2)
nc_close(nc_cd3)
nc_close(nc_cd4)
nc_close(nc_cd5)
nc_close(nc_cd6)
nc_close(nc_cd7)
nc_close(nc_cd8)
nc_close(nc_cd9)
nc_close(nc_cd10)
nc_close(nc_cd11)
nc_close(nc_cd12)
nc_close(nc_cd13)
nc_close(nc_cd14)
nc_close(nc_cd15)
nc_close(nc_cd16)
nc_close(nc_cd17)
nc_close(nc_cd18)
nc_close(nc_cd19)

#Time series for carbon flux at given location

cf = c(cd1_cf[32,47],cd2_cf[32,47],cd3_cf[32,47],cd4_cf[32,47],cd5_cf[32,47],
       cd6_cf[32,47],cd7_cf[32,47],cd8_cf[32,47],cd9_cf[32,47],cd10_cf[32,47],
       cd11_cf[32,47],cd12_cf[32,47],cd13_cf[32,47],cd14_cf[32,47],cd15_cf[32,47],
       cd16_cf[32,47],cd17_cf[32,47],cd18_cf[32,47],cd19_cf[32,47])

cf1 = c(cd1_cf[31,45],cd2_cf[31,45],cd3_cf[31,45],cd4_cf[31,45],cd5_cf[31,45],
        cd6_cf[31,45],cd7_cf[31,45],cd8_cf[31,45],cd9_cf[31,45],cd10_cf[31,45],
        cd11_cf[31,45],cd12_cf[31,45],cd13_cf[31,45],cd14_cf[31,45],cd15_cf[31,45],
        cd16_cf[31,45],cd17_cf[31,45],cd18_cf[31,45],cd19_cf[31,45])

cf2 = c(cd1_cf[31,46],cd2_cf[31,46],cd3_cf[31,46],cd4_cf[31,46],cd5_cf[31,46],
        cd6_cf[31,46],cd7_cf[31,46],cd8_cf[31,46],cd9_cf[31,46],cd10_cf[31,46],
        cd11_cf[31,46],cd12_cf[31,46],cd13_cf[31,46],cd14_cf[31,46],cd15_cf[31,46],
        cd16_cf[31,46],cd17_cf[31,46],cd18_cf[31,46],cd19_cf[31,46])

cf3 = c(cd1_cf[30,45],cd2_cf[30,45],cd3_cf[30,45],cd4_cf[30,45],cd5_cf[30,45],
        cd6_cf[30,45],cd7_cf[30,45],cd8_cf[30,45],cd9_cf[30,45],cd10_cf[30,45],
        cd11_cf[30,45],cd12_cf[30,45],cd13_cf[30,45],cd14_cf[30,45],cd15_cf[30,45],
        cd16_cf[30,45],cd17_cf[30,45],cd18_cf[30,45],cd19_cf[30,45])

#creating a dataframe of flux values
cf_ts <- data.frame(year = 2000:2018, Carbonflux = cf, Carbonflux1 = cf1,
                    Carbonflux2 = cf2, Carbonflux3 = cf3)


#Plots
cfts1 <- ggplot(cf_ts, aes(x=year, y=Carbonflux)) +
  geom_line() +
  geom_smooth(level=0.99)+
  labs(y = 'Carbon flux (in kgC m^-2 month^-1')+
  ggtitle("Carbon flux at Site 1")      # Set title



cfts2 <- ggplot(cf_ts, aes(x=year, y=Carbonflux1)) +
  geom_line() +
  geom_smooth(level=0.99)+
  labs(y = 'Carbon flux (in kgC m^-2 month^-1')+
  ggtitle("Carbon flux at Site 2 ")      # Set title


cfts3 <- ggplot(cf_ts, aes(x=year, y=Carbonflux2)) +
  geom_line() +
  geom_smooth(level=0.99)+
  labs(y = 'Carbon flux (in kgC m^-2 month^-1')+
  ggtitle("Carbon flux at Site 3")      # Set title

cfts4 <- ggplot(cf_ts, aes(x=year, y=Carbonflux3)) +
  geom_line() +
  geom_smooth(level=0.99)+
  labs(y = 'Carbon flux (in kgC m^-2 month^-1')+
  ggtitle("Carbon flux at Site 4")      # Set title

grid.arrange(cfts1,cfts2,cfts3, cfts4,  ncol=2,nrow=2)