spam <- read.csv("C:\\Users\\86133\\Desktop\\spam.csv",encoding="UTF-8")
head(spam)
plot(density(spam$num000[spam$type == "nonspam"]),col = "red",main = "",
     xlab = "Frequence of 'internet'")+abline(v=0.5,col="black")+
    lines(density(spam$num000[spam$type == "spam"]),col = "blue")

prediction <- ifelse(spam$num000 > 0.2 ,"spam","nonspam")

table(prediction,spam$type)/dim(spam)[1]
sum(diag(table(prediction,spam$type)/dim(spam)[1]))