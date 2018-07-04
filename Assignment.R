library(R.utils)

setwd("~/Roel/Studie/Economy/IOM")
load("~/Roel/Studie/Economy/IOM/WIOT2014_October16_ROW.RData")
typeof(wiotdf)
Country = 'DEU'
IndustryCode = 'C17'

totalvalueadded = wiotdf["VA",]
wiot$Country
CountryVector = wiot$Country == Country
wiotDEU = wiot[CountryVector,]
#iifmatrix is composed of 56 industries.
iiflowmatrix = wiotDEU[566:621]
# domestic output is assumed to be in excel file
totaloutput = wiotDEU["TOT"]
# domestic input is assumed to be in excel file
valueaddedvector = wiot$IndustryCode == "VA"
valueadded = wiot[valueaddedvector,566:621]



# total output is sum of industry output + final demand
# here, we don't have final demand yet. So we need to
# calculate it. So we sum all columns together, then 
# calculate the difference between sum and total output

rowsums = rowSums(iiflowmatrix)
findemand = totaloutput-rowsums

# write csv's

write.csv(wiotDEU,file="wiotDEU.csv")
write.csv(iiflowmatrix,file="flowmatrix.csv")
write.csv(wiot,file="wiot.csv")
write.csv(valueadded,file="valueadded.csv")

# Let's calculate A:

inverse = totaloutput^-1
identmatrix=diag(56)

z = inverse*diag(56)

A = sweep(iiflowmatrix,margin=2,totaloutputvector,'/')


IndustryVector = wiotDEU$IndustryCode == IndustryCode
wiotFinal = wiotDEU[IndustryVector,]

CornEcon = wiotFinal$DEU8