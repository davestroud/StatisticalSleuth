library(Sleuth3)
library(leaps)
str(case1201)
attach(case1201)
View(case1201)

# Exploration
logTakers <- log(Takers)

myMatrix <-cbind(SAT, logTakers, Income, Years, Public, Expend, Rank)
if(require(car)){ # Use the car library
  scatterplotMatrix(myMatrix, diagonal="histogram", smooth=FALSE)
    }

State[Public < 50] # Identify state with low Public (Louisiana)                    
State[Expend > 40] # Alaska


myLm1 <- lm(SAT ~ logTakers + Income + Years + Public + Expend + Rank)
plot(myLm1, which=1)

plot(myLm1, which = 4) # Cooks Distance

State[29] # Identify State number 29? ([1] Alaska)

plot(myLm1, which = 5)

if(require(car)) { # Use the car library
  crPlots(myLm1) # Partial residual plot
}

myLM2 <- update(myLm1, ~ . , subset(State != "Alaska"))
plot(myLM2, which = 1)
plot(myLM2, which = 4)
if(require(car)){ # Use the car library
  cr.plots(myLM2) # Partial residiual plot
} 

## Rank states on SAT scores, Adusted for Takers and Rank
myLM3 <- lm(SAT ~ logTakers + Rank)
myResiduals <- myLM3$res
myOrder <- order(myResiduals)
State[myOrder]

## Display for presentation
dotchart(myResiduals[myOrder], labels = State[myOrder],
         xlab = "SAT Scores, Adjusted for Percent Takers and HS Ranks (Deviation From Average)",
         main = "States Ranked by Adjusted SAT Scores",
         bg = "green", cex=.8)
        abline(v=0, col="gray")

## Variable Selection (For ranking states after accounting for all variables)
expendSquared <- Expend^2
if (require(leaps)) { # Use the leaps library
  mySubsets <- regsubsets(SAT ~ logTakers + Income + Years + Public + Expend +
                            Rank + expendSquared, nvmax=8, data=case1201, subset=(State != "Alaska"))
}
mySummmary <- summary(mySubsets)
p <- apply(mySummmary$which, 1, sum)
plot(p, mySummmary$bic, ylab = "BIC")
cbind(p, mySummmary$bic)
myLm4 <- lm(SAT ~ logTakers + Years + Expend + Rank, subset = (State != "Alaska"))
summary(myLm4)

# Display for presentation
myResiduals2 <- myLm4$res
myOrder2 <- order(myResiduals2)
newState <- State[State != "Alaska"]
newState[myOrder2]
dotchart(myResiduals2[myOrder2], labels = State[myOrder2],
         xlab = "Adjusted SAT Scores (Deviation from Average Adjusted Value)",
         main = paste("States ranked by SAT scores adjusted for Demographics",
                      "of Takers and Education Expenditure", sep = " "),
         bg="green", cex = .8)
        abline(v=0, col="gray")
        
         
         
         
         
         
           
        



