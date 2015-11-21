# Getting and Cleaning Data: Course Project

## Overview
The included R script in this repository demonstrates another amazing capability of R in data manipulation such as collecting, processing, organizing and sanitizing any type of datasets. 

## Contents
* README.md - This file
* Codebook.md - A document that list all the data set fields use.
* run_analysis.R - A script written by me that process a raw dataset into a tidy dataset as required by this project.

## Methodology

#### Data Collection and Extraction
The compressed raw dataset is downloaded online and extracted programmatically in R. 
A detailed specification of the dataset can be found at [The UCI Machine Learning Repository.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  
The raw dataset can be [downloaded here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

#### Data Binding and Merging
This method uses the R native functions such as cbind, rbind and merge functions to combine various datasets into a single dataset.

#### Data Subsetting and Processing
This step selects only the required columns and processed the values by extracting only the measurements on the mean and standard deviation for each measurement.

#### Data Labeling
Method in step 4 (see run_analysis.R) that handles column labeling using descriptive names and appropriate labels.

#### Data Formatting and Reproduction
Data is reproduced independently after sanitizing, organizing and calculating the average of each variable for each activity on each data field. The reproduced dataset is saved as a comma separated value in a text file.
