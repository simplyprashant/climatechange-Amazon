library(mgcv) ## GAM modeling
library(ggplot2)
library(ncdf4) ## handling netCDF files

#Setting folder location
folder <- "C:/Users/prash/Desktop/Project/Carbon flux"

#Getting the list of all files
files <- list.files(folder, full.names = TRUE)

#creating empty vector
df <- c()

#Appending flux values for site 1
for(file in files){
  
  nc <- nc_open(file)
  flux <- ncvar_get(nc, "flux_apos_bio")
  df <- append(df, flux[32,47])
}

#creating a date sequence
er <- seq(as.Date("2000-01-01"),as.Date("2018-12-01"), by = "months")
er


#creating a data frame o flux values
timeseries <- data.frame(Time = er, Carbon_flux = df, timestep = seq(1,228))

#Extracting month values for new column
timeseries$month <- format(as.Date(timeseries$Time, format="%d/%m/%Y"),"%m")

#Month wise flux plot
ggplot(timeseries, aes(x=Time, y=Carbon_flux)) +
  geom_point()+
  geom_line() +
  geom_smooth(method='lm')+
  facet_wrap(.~month, ncol =4)+
  ggtitle("Month wise Carbon flux trend at Site 1")


#Fitting GAM model
model0 <- gam(Carbon_flux ~ s(timestep, k=10, bs='cs'),
              data = timeseries,
              family = gaussian(link = 'identity'))

# Summary statistics
summary(model0)

# 2nd model
model1 <- gam(Carbon_flux ~ s(timestep, k=50, bs='cs'),
              data = timeseries,
              family = gaussian(link = 'identity'))

summary(model1)

#3rd model
model2 <- gam(Carbon_flux ~ s(timestep, k=200, bs='cs'),
              data = timeseries,
              family = gaussian(link = 'identity'))

summary(model2)

#4th model
model3 <- gam(Carbon_flux ~ s(timestep, k=100, bs='cs'),
              data = timeseries,
              family = gaussian(link = 'identity'))

summary(model3)

#x values to predict on
xx<-seq(min(timeseries$timestep),max(timeseries$timestep),length=228) 

#Predicting model mean 
pred1 <-predict(model2,newdata=data.frame(timestep=xx), se.fit = T) 
pred2 <- predict(model3,newdata=data.frame(timestep=xx), se.fit = T) 

#Plotting model results 

plot(timeseries$timestep,timeseries$Carbon_flux,pch=20, xlab='Time'
     ,ylab='Carbon flux')
lines(xx,pred1$fit,lwd=1,col="blue")
lines(xx,pred1$fit+1.96*pred1$se.fit,col="red",lwd=1,lty=4) 
lines(xx,pred1$fit-1.96*pred1$se.fit,col="red",lwd=1,lty=4)


#model check
par(mfrow = c(2,2))

gam.check(model2, pch=20)
gam.check(model3, pch=20)


#########################################
##ARIMA

library(forecast) #forecast ARIMA

#creating time series object
cfts <- ts(timeseries$Carbon_flux, start = c(2000,1),
           frequency = 12)

#Plotting flux values
plot(cfts)

#Decompose and plotting components
component <- decompose(cfts)
plot(component)

#Auto ARIMA without seasonality
mod0 <- auto.arima(cfts, max.p = 4,max.q = 4,max.d = 4, seasonal = F)
mod0

#Fitting default model
moda <- arima(cfts, c(0,0,2))
moda

#Plotting the fitted values
plot(cfts)
lines(fitted(moda), lwd = 2, lty = 2, col = 'red')

#2nd model
modb <- arima(cfts, c(1,0,2))
modb

#Plotting fitted values
plot(cfts)
lines(fitted(modb), lwd = 2, lty = 2, col = 'blue')

#Prediction
pred_arima <- predict(modb, n.ahead = 12)

#Forecasting for 12 time steps
fc <- forecast(moda, h=12)
autoplot(fc)

######################Seasonal ARIMA#########################################
#############################################################################

#Auto ARIMA with seasonality
mod1 <- auto.arima(cfts, max.p = 4,max.q = 4,max.d = 4, seasonal = T)
mod1

#deafult model
modc <- arima(cfts, order = c(2,0,1), seasonal = c(0,0,2))
modc
plot(cfts)
lines(fitted(modc), lwd = 2, lty = 2, col = 'red')

#Forecasting
fc1 <- forecast(modc, h=12)
autoplot(fc1)

#2nd model
modd <- arima(cfts, order = c(2,1,1), seasonal = c(0,0,2))
modd

#3rd model
modf <- arima(cfts, order = c(2,0,1), seasonal = c(0,0,1))
modf

#plotting fitted values
plot(cfts)
lines(fitted(modf), lwd = 2, lty = 2, col = 'red')

#Forecasting future values
fc2 <- forecast(modf, h=12)
autoplot(fc2)
