## Code Book

This code book contains every modification of original data.

### Source

The required data can be found in

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Participants

Total numbers: 30
Ages: 19-48 yrs old
Recruiting Criteria: volunteered


### Data Acquiring Method

- Wearing Samsung Galaxy S II equipped with 3-axial acclerometer and gyroscope.
- Performing six activities including walking, walking upstairs, walking downstairs, sitting, standing and laying.
- Recording video while performing activities.
- Collecting 3-axial linear accleration and 3-axial angular velocity with the rate of 50hz.
- Randomly selected 70% of volunteer sets into train group and 30% of them sets into test group.


### Data

- 3-axial acceleration including the estimated body acceleration
- 3-axial angular velocity
- 561-feature vector with the time and frequency domain variables.
- Activity labels
- Identifier of the subject.


### 1. Merges the training and the test sets to create one data set.

The downloaded file is compressed with ZIP. Unzip the file contains files and folders, which are:
- feature.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- x_test.txt
- y_test.txt
- subject_test.txt

Table index:
- features: data table from features.txt
- activity.labels: data table from activity_labels.txt
- subject.train: data table from subject_train.txt
- subject.test: data table from subject_test.txt
- x.train: data table from x_train.txt
- y.train: data table from y_train.txt
- x.test: data table from x_test.txt
- y.test: data table from y_test.txt

The column names is modified with:
- subject.test and subject.train > subject.ID
- activity.labels > activity.ID and activity.Type
- x.train and x.test > selelcted values from column 2 of features table. 
- y.train and y.test > activity.ID

Train group data is merged into train.set with the verb cbind().
Test group data is merged into test.set with the verb cbind().

Finally, train.set and test.set are merged into merged.tbl with the verb rbind().
 

### 2. Extracts only the measurements on the mean and stadard deviation for each measurement.

Tatics is to draw variables from merged.tbl and make a vector named all.variables. And Using grepl() and 
logical calculation, 'mean()', 'std()', 'activity.ID' and 'subject.ID' are used to the partial matching variables. 
Then subsetting merged.tbl assigns into selected.tbl.


### 3. Use descriptive activity names to name the activities in the data set.

How to is to collect the variables from selected.tbl and to using grepl() to selecting the columns 
only interested. Then put them into the selected2.tbl. by using merge().


### 4. Appropriately labels the data set with descriptive variable names.

Abbreiviation: 
- t: time
- f: frequency
- Acc: accelerometer
- Gyro: gyroscope
- Mag: magnitude
- BodyBody: body

Using gsub(), changed variables to be descriptive names.


### 5. From the data set in step 4, creates second, independent tidy data set with the average of each variable
for each activity and each subject.

'tidy.tbl' is final and tidy data sets. Using aggregate() from plyr library makes it done. And then the table
is written in file "tidydata.txt"

