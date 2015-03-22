### Load features
features = read.table("features.txt")
# We want to keep mean and std columns only
cols_to_keep = grep('-(mean|std)\\(', features$V2, ignore.case = TRUE)
# Add a new V3 column that is the same as V2 minus (' and ')' characters
features$V3 = gsub('\\(\\)', '', features$V2)
# Subset features to only keep those mean/std columns
features1 = features[cols_to_keep,]

### Load train data
X_train = read.table("train/X_train.txt")
# Keep mean and std columns only
X_train1 = X_train[cols_to_keep]  
# Rename columns with better names
names(X_train1) <- features1$V3  

# Add Activity type column
y_train = read.table("train/y_train.txt")
X_train1$ActivityType = y_train$V1

# Add Subject ID column
subject_train = read.table("train/subject_train.txt")
X_train1$SubjectId = subject_train$V1  ## Add Subject Id

### Load test data
X_test = read.table("test/X_test.txt")
# Keep mean and std columns only
X_test1 = X_test[cols_to_keep]
# Rename columns with better names
names(X_test1) <- features1$V3

# Add Activity type column
y_test = read.table("test/y_test.txt")
X_test1$ActivityType = y_test$V1

# Add Subject ID column
subject_test = read.table("test/subject_test.txt")
X_test1$SubjectId = subject_test$V1

# Concatenate train and test data
X_result <- rbind(X_train1, X_test1)

# Replace 'activity codes' with more explicit 'activity labels' 
activity_labels = read.table("activity_labels.txt")
res = merge(X_result, activity_labels, by.x="ActivityType", by.y="V1")
# Remove old ActivityType column ('activity codes')
res <- subset(res, select = -c(ActivityType))
# Rename V2 column into ActivityType
names(res)[names(res) == "V2"] = "ActivityType"
# Reorder columns to put SubjectId and ActivityType at the beginning
res1 <- res[c(67,68,1:66)]

### Create independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
res2 = res1 %>% group_by(SubjectId, ActivityType) %>% summarise_each(funs(mean))
res2
mean(res1[res1$SubjectId == 1 & res1$ActivityType == "WALKING", "tBodyAcc-mean-X"])
write.table(res2, file="tidydata.txt")