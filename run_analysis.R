#script for Cleaning Data Course Project

setwd('UCI HAR Dataset')
#Read in data
d <- function(tp = 'train') {
        sid <- read.table(paste(tp,"/subject_",tp,".txt",sep=''),col.names='sid')
        act.id <- read.table(paste(tp,'/y_',tp,".txt",sep=''),col.names='actid')
        #Uses descriptive activity names to name the activities in the data set
        act.labels <- read.table('activity_labels.txt',col.names=c('actid','actName'))
        act.id <-merge(act.id,act.labels,by='actid')
        feat.labels <- read.table('features.txt',col.names=c('num','name'))
        train <-read.table(paste(tp,'/X_',tp,'.txt',sep=''),col.names=feat.labels$name)
        #Extracts only the measurements on the mean and standard deviation for each measurement. 
        keep <- union(grep('[Mm]ean',feat.labels$name),grep('[Ss]td',feat.labels$name))
        train <- train[,keep]
        train <- cbind(sid,act.id,train)
        train$type <- tp
        return(train)
}

#read in the train and test data sets
train<-d('train')
test <- d('test')

#Merges the training and the test sets to create one data set.
allData <- rbind(train,test)

#remove periods from variable names
names(allData) <- gsub('[[:punct:]]','',names(allData))

#Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
tidySum <- NULL
for(subNum in unique(allData$sid)){
        thisSub <- subset(allData,sid==subNum)
        tidySum <- rbind(tidySum,aggregate(thisSub, by=list(thisSub$actName), FUN=mean))
}
#remove actid, actName, type from tidySum
tidySum <- tidySum[,!names(tidySum) %in% c('actid','actName','type')] 
names(tidySum)[names(tidySum)=='Group.1'] <- 'ActivityName'

#write the table
write.table(tidySum,file='tidySum.txt',row.name=F)
