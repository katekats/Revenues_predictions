
#----setup---------
 library(tsoutliers)
 library(forecast)

# import the Revenues.csv file
 revenues = read.csv("C:\\Revenues.csv")

#------ identify and replace the outliers from the time series----
 rev = tsclean(ts(revenues[,2]))

#---- plot the time series----
 plot(rev, xlab="day", ylab="Revenues")

#---ACF and PACF plots-------
 par(mfrow = c(2, 1))
 acf(rev, 40)
 pacf(rev, 40)

#--first difference plot---
 rev2 = diff(rev)
 par(mfrow = c(1, 1))
 plot(rev2)

#----ACF and PACF from first difference
 par(mfrow = c(2, 1))
 acf(rev2, 40)
 pacf(rev2, 40)


 
#------ fit the first model-----
 rev5.fit3 = arima(rev, order=c(1,1,1), seasonal=list(order=c(2,0,0), period=6))
 rev5.fit3

#----fit the second model----
 rev6.fit3 = arima(rev, order=c(1,1,0), seasonal=list(order=c(1,0,0), period=6))
 rev6.fit3

#----fit the third model----
 rev6.fit3 = arima(rev, order=c(1,1,0), seasonal=list(order=c(1,0,0), period=6))
 rev6.fit3

#------diagnostics--------
 tsdiag(rev5.fit3, gof.lag=40)
 

 par(mfrow = c(2,1))
 hist(rev5.fit3$resid, br=12)
 qqnorm(rev5.fit3$resid)
 shapiro.test(rev5.fit3$resid)

  

#-------forecast for the final model
 rev5.pr = predict(rev5.fit3, n.ahead=15)
 U = rev5.pr$pred + 2*rev5.pr$se
 L = rev5.pr$pred - 2*rev5.pr$se
 day = 1:305
 plot(day, rev[day], type="o", xlim=c(1,335), ylim=c(-22000, 60000), ylab="Revenues")
 lines(rev5.pr$pred, col="red", type="o")
 lines(U, col="blue",lty="dashed")
 lines(L, col="blue",lty="dashed")
 abline(v=305.5,lty="dotted")
 
#------- the predicted values and upper and lower limits
 rev5.pr$pred
 U
 L


