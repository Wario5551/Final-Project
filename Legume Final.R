legume = `Magnoli&Lau_multistraindata`
View(legume)
#This code is so as to get rid of any null values since they really won't help with the data analysis as a whole
legume = na.omit(legume)
#These lines of code are to seperate the levels of nitrogen in the soil as well as seperating the different kinds of rhizobia that is present in the soil
legumeHighN = legume[legume$nitrogen == "high",]
legumeLowN = legume[legume$nitrogen == "low",]
legumeNoRhizobia = legume[legume$Rhizobia =="No rhizobia",]
rhizobiaLux = legume[legume$Rhizobia == "Lux",]
rhizobiaMarshall = legume[legume$Rhizobia == "Marshall",]

#Recoding Data
#I'm removing these columns because they are redundant to the data set  
legume$rhizobia.type = NULL
legumeLowN$rhizobia.type = NULL
legumeHighN$rhizobia.type = NULL
#Recoding the valuses in these columns so that the correlation matrix can be done 
legume$nitrogenR <- revalue(legume$nitrogen, c("high"="1", "low"="2"))
legume$PopulationR <- revalue(legume$Population, c("Lux"="1", "Original"="2", "Marshall"="3"))
legume$RhizobiaR <- revalue(legume$Rhizobia, c("Lux"="1", "No rhizobia"="2", "Marshall"="3"))
#Removing the columns that the recoding columns originated from so that it doesn't mess with the correlation matrix
legumeR = legume[,!names(legume) %in% c("nitrogen", "Population", "Rhizobia")]
View(legumeR)
#Correlation Matrix
#Checking to see what the data types are for each column of the data set
str(legume)
#Changing the data type of all non numeric columns so that I can perform a correlation matrix
legumeR$nitrogenR = as.numeric(legumeR$nitrogenR) 
legumeR$RhizobiaR = as.numeric(legumeR$RhizobiaR) 
legumeR$PopulationR = as.numeric(legumeR$PopulationR)
legumeR$plant = as.numeric(legumeR$plant)
legumeR$rack = as.numeric(legumeR$rack) 
legumeR$nodules = as.numeric(legumeR$nodules)
legumeR$alive = as.numeric(legumeR$alive) 
#Removing the alive column so as to make a proper correlation matrix
legumeRNoLive = legumeR
legumeRNoLive$alive = NULL

legumeCor <- cor(legumeRNoLive)
round(legumeCor, 2)

