
#!/bin/bash

#This script will allow you to copy and paste any BigQuery query directly in.

#The following command and parameters can be found at from https://cloud.google.com/bigquery/bq-command-line-tool.
#You can add all the options you would normally find in the Big Query UI.
bq query \
--destination_table=[MyDataset].TempTable \
--append_table \
--use_legacy_sql=false
<<EOF
--<<Add your query here>>
SELECT *
FROM TABLE_DATE_RANGE([MyDataset.ga_sessions_],DATE_ADD(TIMESTAMP(CURRENT_TIMESTAMP()), -1, 'DAY'),DATE_ADD(TIMESTAMP(CURRENT_TIMESTAMP()), -8, 'DAY'))
EOF

#You can have multiple queries in one script. They will run one after the other which allows you to create new tables, and then use them immediately.
bq query \
--destination_table=[MyDataset].MyDestinationTable \
--append_table \
--use_legacy_sql=false
<<EOF
--<<Add your query here>>
SELECT *
FROM TABLE_DATE_RANGE([MyDataset.TempTable]
EOF