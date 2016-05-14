## Tidy Data Creator - Galaxy fit metrics
## This script generates an integrated, summarized set of data using several
## data files containing activity measurements from a Galaxy smartphone for a
## group of test subjects.

## Build integrated test table

# Read in the 3 files of test data
test_var <- read.table("test/X_test.txt")
test_activity <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

# Add variable column names (from "features" file) to test_var table
var_names <- read.table("features.txt")
colnames(test_var) <- var_names$V2

# After assigning unique column names, bolt on the activity and subject 
# data sets as additional columns in the main table -->  test_var
colnames(test_activity) <- "activity"
colnames(test_subject) <- "subject"
test_var <- cbind(test_var,test_activity,test_subject)

## Build integrated train table

# Read in the 3 files of train data
train_var <- read.table("train/X_train.txt")
train_activity <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

# Add variable column names (from "features" file) to train_var table
colnames(train_var) <- var_names$V2

# After assigning unique column names, bolt on the activity and subject 
# data sets as additional columns in the main table -->  train_var
colnames(train_activity) <- "activity"
colnames(train_subject) <- "subject"
train_var <- cbind(train_var,train_activity,train_subject)

## Combine test and train table into single table ("all_data")
all_data <- rbind(test_var,train_var)

## Add column with activity description using table "activity_labels"
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity","activity_desc")
all_data <- merge(all_data,activity_labels)

# Identify columns that include a mean or standard deviation variable,
# Or identify activity or subject
select_columns <- grep("[Mm]ean|std|activity|subject",names(all_data))

# Create new table (filtered_data) with only these columns
filtered_data <- all_data[,select_columns]

# Re-order columns to put activity and subject first
filtered_data2 <- filtered_data[,c(89,88,2:87,1)]

# Create summary table
# Aggregate measures by averaging by activity and subject 
summary_data <- aggregate(filtered_data2[,3:88],list(filtered_data2$activity,filtered_data2$subject), mean)
colnames(summary_data)[1] <- "activity"
colnames(summary_data)[2] <- "subject"

# Write the summary table to a local file called "summary_data.txt"
write.table(summary_data,file="summary_data.txt",row.names=FALSE)