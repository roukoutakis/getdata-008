# run_analysis.R getdata-009

require(data.table)

# 0. Gets the data and loads them in memory.
if(!file.exists("./UCI HAR Dataset")) {
  if(!file.exists("UCI HAR Dataset.zip")) download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="UCI HAR Dataset.zip", method="curl")
  unzip("UCI HAR Dataset.zip")
}

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_features <- grepl("mean|std", features$V2)
features <- features[mean_std_features,]
X_test <- X_test[,mean_std_features]
X_train <- X_train[,mean_std_features]

# 3. Uses descriptive activity names to name the activities in the data set
y_test$V1 <- factor(y_test$V1, levels=activity_labels$V1, labels=activity_labels$V2)
y_train$V1 <- factor(y_train$V1, levels=activity_labels$V1, labels=activity_labels$V2)

# 4. Appropriately labels the data set with descriptive activity names.
colnames(X_test) <- features$V2
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"
colnames(X_train) <- features$V2
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"

# 1. Merges the training and the test sets to create one data set.
test_data <- cbind(X_test, y_test)
test_data <- cbind(test_data, subject_test)
train_data <- cbind(X_train, y_train)
train_data <- cbind(train_data, subject_train)
data <- as.data.table(rbind(test_data, train_data))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- data[,lapply(.SD,mean),by = "Activity,Subject"]
tidy <- tidy[order(Subject),]
write.table(tidy, file="tidy.txt", row.names = FALSE)
