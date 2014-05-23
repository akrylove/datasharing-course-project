To produce a tidy data set, run run_analysis.R script.

If you don't have the original .zip file, run the script and it will automatically download the file and unzip into "UCI HAR Dataset" subdirectory of your working directory.

If you already have the project data, store it in the Dataset.zip file and unzip that file into "UCI HAR Dataset" subdirectory of your working directory.  The run_analysis.R script will then read the data from files/dirs in "UCI HAR Dataset" directory.

The run_analysis.R script reads in all the necessary data, performs data transformations and writes out "tidy_data.txt" file into your working directory.

The files that are needed to run the analysis are:
- the original data set zip file and all of its unzipped contents and
- run_analysis.R script file

If the original data set zip file is not available, the script will download it.
