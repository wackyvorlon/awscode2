#! /bin/bash


RDSHOST="database-2.cahtjzuqlnvl.us-east-1.rds.amazonaws.com"
TOKEN="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 3306 --region us-east-1 --username dbuser )"


mysql --batch --user=dbuser --password=$TOKEN --database=foo --host=$RDSHOST --port=3306 --ssl-ca=global-bundle.pem -e "SELECT * FROM Persons;" \
 | sed "s/\"/\"\"/g;s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > foo.csv

aws s3 cp foo.csv s3://cvsbackup2