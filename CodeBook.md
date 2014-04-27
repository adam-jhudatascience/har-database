Code book for har-database
==========================
This is the code book for the dataset *tidyData.txt* from the har-database repo. 

Variable names and descriptions
-------------------------------
The columns of the data are labeled with the variable names listed in the next section, along with their descriptions. The names of the variables and their full descriptions can be found in the files *features.txt* and *features_info.txt* located in the "UCI HAR Dataset" directory of the ZIP archive found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The variable names in *tidyData.txt* do not have exactly the same meaning as they did in the original UCI HAR dataset. In the original, for each subject-activity combination, there are several values of the variables, corresponding to several windows of fixed durations extracted from the accelerometer signal. In *tidyData.txt*, each variable has only one value for each subject-activity combination, comprising the arithmetic means of the values for that combination from the original dataset.

Transformations on the data
---------------------------
The script *run_analysis.R* performs the following manipulations. All file paths are expressed relative to the top level directory "UCI HAR Dataset" obtained by extracting the ZIP archive from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). *run_analysis.R* assumes the file "getdata projectfiles UCI HAR Dataset.zip" is in the same directory, which has been set to the working directory of R.
1. The test data are obtained from *test/X_test.txt* and read into a dataframe. The training data are obtained from *train/X_train.txt* and read into a separate dataframe. To each observation (corresponding to a row) in the test and training dataframes, an identifier for the human subject is obtained from *test/subject_test.txt* and *train/subject_train.txt* respectively. These dataframes are then concatenated using `rbind()`.
2. All columns are labeled using the variable names from "features.txt".
3. The activity labels, which are integers from 1 to 6, are replaced with descriptive names obtained from *activity_labels.txt*.
4. All columns corresponding to variable names that do not contain 'mean()' or 'std()' are dropped.
5. All observations for each remaining variable corresponding to the same (subjectIds, activityIds) pair are reduced to one observation, corresponding to their arithmetic mean.
6. This new, reduced dataset is written to *tidyData.txt* using the `write.table()` command.
