
#!/bin/bash

#This script will allow you to loop through date partionted tables and create a new date partioned dataset too.

DATENUM=1 #Add your start day number relative to today. 1 would be yesterday, 2 would be two days ago etc.
until [ ! $DATENUM -lt 8 ]; do #Add your end date number here PLUS ONE. You need to add one otherwise the loop would complete a day too early.

#The above would look at the last seven days of data, excluding today.

TABLEDATE=$(date --date="-$DATENUM day" +"%Y%m%d") #This is the date format we will use to query BQ and create the date partioned tables.

#The following command and parameters can be found at from https://cloud.google.com/bigquery/bq-command-line-tool.
#You can add all the options you would normally find in the Big Query UI.

#This script uses Shell variables directly in the query which allows you to create data partioned tables one after the other.

bq query \
--destination_table=MyDataset.TempTable_$TABLEDATE \
--allow_large_results \
--replace <<EOF
--<<Add your query here>>
--You can have line breaks and white space. Literally a C&P from Big Query
SELECT *
FROM TABLE_DATE_RANGE([MyDataset.ga_sessions_],TIMESTAMP('$TIMESTAMPDATE'),TIMESTAMP('$TIMESTAMPDATE'))
EOF

#You can have multiple queries in one shell script. The queries will run one after the other and can be handy for creating and analysing new tables.
bq query \
--destination_table=MyDataset.MyDestinationTable_$TABLEDATE \
--allow_large_results \
--replace <<EOF
--<<Add your query here>>
SELECT *
FROM [MyDataset.TempTable_$TABLEDATE]
EOF

DATENUM=$((DATENUM+1)) #This adds one to our date variable to keep the loop goign untill we reach the final date.

DONE
