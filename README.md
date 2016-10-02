# Utilisation de l'outil mdb-tools
Mdb-tools permet d'importer une base de données access mdb vers postgres.  

#### Installation - Linux

	sudo apt-get install mdbtools

#### Lister les tables d'une base de données

	mdb-tables ma_base.mdb

#### Créer les tables dans la base de données postgres
Cette commande génére l'architecture de la base de données avec les tables vides. Les tables sont créés dans le schéma 'public'.

	mdb-schema ma_base.mdb postgres | psql -d nom_bd_pg -U user -W -h localhost
	mdb-schema CETUS_FICHOBS_Modif.mdb postgres | psql -d access -U odk_user -W -h localhost
	
#### Insérer les données dans la base de données postgres
Cette commande réalise des 'INSERT INTO...'. Il faut la réaliser pour chaques tables de la bd mdb. 
A noter que la base de réception doit être en UTF-8 pour éviter les problèmes d'encodages.  

-q "'"   Pour mettre les textes entre ' et non "  
-R ";\n" Pour indiquer la forme des sauts de lignes  
-I 'postgres' Pour indiquer que l'on veut un code compatible Postgres.  

	mdb-export -q "'" -R ";\n" -I 'postgres' ma_base.mdb nom_table | psql -d nom_bd_pg -U odk_user -W -h localhost
	mdb-export -q "'" -R ";\n" -I 'postgres' CETUS_FICHOBS_Modif.mdb AUTRE_ESPECE | psql -d access -U odk_user -W -h localhost

> Les colonnes en boolean pausent des problèmes il faut les recréer en integer avant de faire les imports
	
#### Utilisation du script 'mdbconvert.sh'

	chmod 755 mdbconvert.sh  
	  
	./mdbconvert.sh ma_base.mdb nom_bd_pg
	./mdbconvert.sh CETUS_FICHOBS_Modif.mdb access