har-database
============
This repo includes an R script to obtain a tidy data set containing acceleration data for a variety of human activities, and the tidy data set itself.

Contents
--------
This repo comprises the files:
- *README.md*, this readme file.
- *tidyData.txt*, a dataset containing acceleration data for a variety of human activities measured with the accelerometer in a Samsung Galaxy S smartphone.
- *run_analysis.R*, an R script that produces the tidyData.txt dataset from the data found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
- *CodeBook.md*, a code book describing the variables, data and transformations applied to the data obtained from the link above in order to obtain tidyData.txt.

Instructions
------------
1. Download *run_analysis.R* from this repo to a local directory *my-directory* on your computer.
2. Set the working directory for R to *my-directory*.
3. Download this [file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and save in *my-directory*.
4. Run the file *run_analysis.R* in R; this will produce *tidyData.txt*. See *CodeBook.md* from this repo for a description of the variables and data in the dataset.

