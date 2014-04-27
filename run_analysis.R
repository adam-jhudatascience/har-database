fileName <- "getdata-projectfiles-UCI HAR Dataset.zip" # Name of ZIP archive containing data
archive_list <- unzip(fileName, list = T) # Listing of ZIP archive
var_names <- read.table(unz(fileName, filename="UCI HAR Dataset/features.txt"), as.is=T)
names(var_names) <- c("index", "variable_name")

print("Loading subject IDs...")
# Load subject IDs.
test_subject_IDs <- read.table(unz(fileName, filename="UCI HAR Dataset/test/subject_test.txt"))
train_subject_IDs <- read.table(unz(fileName, filename="UCI HAR Dataset/train/subject_train.txt"))
print("Loading activity IDs...")
# Load activity IDs.
test_activity_IDs <- read.table(unz(fileName, filename="UCI HAR Dataset/test/y_test.txt"))
train_activity_IDs <- read.table(unz(fileName, filename="UCI HAR Dataset/train/y_train.txt"))

# Load test and training data
print("Loading test data...")
test_df <- read.table(unz(fileName, filename="UCI HAR Dataset/test/X_test.txt"))
print("Loading training data...")
train_df <- read.table(unz(fileName, filename="UCI HAR Dataset/train/X_train.txt"))

# Label columns of combined dataframe with variable names.
print("Labelling columns...")
names(test_df) <- var_names[, "variable_name"]
names(train_df) <- var_names[, "variable_name"]
names(test_subject_IDs) <- "subjectIds"
names(train_subject_IDs) <- "subjectIds"
names(test_activity_IDs) <- "activityIds"
names(train_activity_IDs) <- "activityIds"

# Combine test and training data into one dataframe
print("Combining test and training data...")
full_test_df <- cbind(test_subject_IDs, test_activity_IDs, test_df)
full_train_df <- cbind(train_subject_IDs, train_activity_IDs, train_df)
combined_df <- rbind(full_test_df, full_train_df)

# Replace numerical activity IDs with descriptive strings.
print("Replacing activity labels...")
activity_labels <- read.table(unz(fileName, filename="UCI HAR Dataset/activity_labels.txt"))
combined_df[,"activityIds"] <- activity_labels[combined_df[,"activityIds"],2]

# Extract just the mean and standard deviations of each variable for each signal window.
print("Extracting means and standard deviations...")
mean_std_names <- var_names[grep(paste(c("mean\\(\\)", "std\\(\\)"), collapse="|"), var_names$variable_name), "variable_name"]
mean_std_df <- cbind(combined_df[,c("subjectIds", "activityIds")], combined_df[,mean_std_names])

# Create a second, independent, tidy data set with the average values for each variable from the 
# previous dataset (combined_df) for each subject-activity combination.
print("Creating reduced dataset...")
reduced_df <- aggregate(mean_std_df[,3:length(mean_std_df)],by=list(mean_std_df$subjectIds, mean_std_df$activityIds),mean)
names(reduced_df)[1:2] <- c("subjectIds", "activityIds")

# Write the tidy data set to a file.
print("Writing reduced tidy dataset...")
outputFileName <- "tidyData.txt"
write.table(reduced_df, outputFileName)