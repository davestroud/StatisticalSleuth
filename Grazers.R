library(Sleuth3)
attach(case1301)
str(case1301)
# Exploration and Model Development
plot(Cover ~ Treat, xlab='Animals Present',ylab ='Remaining Seaweed Coverage (%)')
myLm1 <- lm(Cover ~ Block + Treat + Block:Treat)
plot(myLm1,which = 1) 
ratio <- Cover/(100-Cover) # Logit transformation
logRatio <- log(ratio) # log[Y/(1-Y)]
myLm2 <- lm(logRatio ~ Block + Treat + Block:Treat)
plot(myLm2, which = 1)
myLm3 <- lm(logRatio ~ Block + Treat)
anova(myLm3, myLm2) # Test for interaction with extra ss F-test
if(require(car)) { # Use the car library 
  crPlots(myLm3) # Partial residual plots
  }
myLm4 <- lm(logRatio ~ Treat)
anova(myLm4, myLm3) # Test for Block effect  
