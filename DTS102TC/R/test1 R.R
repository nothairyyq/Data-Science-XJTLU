trade_data <- read.csv("C:\\Users\\86133\\Desktop\\R\\trade data.csv")

closing_price <- trade_data[,c("Date", "Closing Price")]
names(closing_price)[names(closing_price) == "Closing Price"] <- "Price"
rec <- data.frame(ID = c(1:nrow(closing_price)))
total <- cbind(rec,closing_price)
fit<-lm(Price~ID,data=total)
summary(fit) 

plot(total$ID,total$Price,  
     xlab="Rec",  
     ylab="Price")  
abline(fit)  

fitted(fit)
predict(fit,newdata=data.frame(ID = c(5137:5143), height=7))



