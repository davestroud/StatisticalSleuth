library(Sleuth3)
str(case1701)
attach(case1701)
## EXPLORATION
MagneticForces <- cbind(L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11)
mfCor <- cor(MagneticForces)
round(mfCor,2) # Show correlations, rounded to two digits
