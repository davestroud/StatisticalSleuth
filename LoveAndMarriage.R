library(Sleuth3)
str(case1702)
attach(case1702)

str(case1702)
View(case1702)

## EXPLORATION
x <- cbind(HP,WP,HC,WC) # 4 components of level of love you feel for spouse
y <- cbind(PW,PH,CW,CH) # 4 components of level of love you perceive from spouse
