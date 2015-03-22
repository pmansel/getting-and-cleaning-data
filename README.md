# getting-and-cleaning-data
Course Project for the 'Getting and Cleaning Data' class from the Johns Hopkins University

## Preliminary steps
### Download the data file, uncompress
```R
> download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip", method="curl")
> unzip("Dataset.zip")
> setwd("UCI HAR Dataset/")
```
### Files description
1. run_analysis.R: R script that parses/merges train and test data. Running this script in the directory where Dataset.zip was downloaded and extracted will generate tidydata.txt
2. tidydata.txt: This file has been created by run_analysis.R from the data contained in Dataset.zip
3. codebook.md: Code book that describes the variables from tidydata.txt

