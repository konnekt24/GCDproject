## README.MD


### Getting and Cleaning Data Course Project.

File name: run_analysis.r
Additional library: plyr. 1.8.3.


### Warning
According to warning from plyr library, when you plan to use 'dplyr' and 'plyr' at the time, Loading 'plyr'
before 'dplyr' can avoid unwanted error.
This script contains the code to load 'plyr'. Be aware.
Because of compatibility issue, I recommend to run the script in R studio. The script contains a verb View() which
might cause compatibility problem.


### Script Action.

After every step of merging tables, there will be the result table popping up.
The strategy of the entire project is following:
- read.table: reading data file and turning into table.
- colnames(): No header is available for the data file. So I label the variables with features.txt.
- cbind(): Each sets of data file is merged by cbind().
- rbind(): Training and Test set are merged by rbind().
- | : Selecting wanted columns contains logical operator 'OR'. 
- grepl(): The fucntion acts as finding partial match with given word and return the result of logical value.
- gsub(): Finding matching string and replacing string.
- write.table(): Final result 'tidy.tbl' is saved as "tidydata.txt".
