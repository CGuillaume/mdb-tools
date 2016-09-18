#!/bin/bash
IFS=! # Permet de gerer les espaces dans les noms de tables
TABLES=$(mdb-tables -d ! $1)

USER="odk_user"
DB="$2"

for t in $TABLES
do
	psql -d $DB -U $USER -w -h localhost -a -c "DROP TABLE IF EXISTS \"$t\" CASCADE"
done

mdb-schema $1 postgres | psql -d $DB -U $USER -w -h localhost

for t in $TABLES
do
    mdb-export -q "'" -R ";\n" -I 'postgres' $1 $t  | psql -d $DB -U $USER -w -h localhost
done
