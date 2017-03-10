
#!/bin/bash

#This script will allow you to copy and paste any BigQuery query directly in.

#The following command and parameters can be found at from https://cloud.google.com/bigquery/bq-command-line-tool.
#You can add all the options you would normally find in the Big Query UI.
bq query \
--destination_table=[MyDataset].MyDestinationTable \
--append_table <<EOF
--<<Add your query here>>
--Query data from last week
SELECT *
FROM TABLE_DATE_RANGE([MyDataset.ga_sessions_],DATE_ADD(TIMESTAMP(CURRENT_TIMESTAMP()), -1, 'DAY'),DATE_ADD(TIMESTAMP(CURRENT_TIMESTAMP()), -8, 'DAY'))
EOF