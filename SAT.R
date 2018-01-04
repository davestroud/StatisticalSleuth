library(Sleuth3)
str(case1201)
attach(case1201)
View(case1201)

# Exploration
logTakers <- log(Takers)
myMatrix <-cbind(SAT, logTakers, Income, Years, Public, Expend, Rank)
if(require(car)){ # Use the car library
  scatterplotMatrix(myMatrix, diagonal="histogram", smooth=FALSE)
    }
                    