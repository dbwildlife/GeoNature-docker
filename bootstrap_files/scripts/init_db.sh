#!/bin/bash

. /usr/local/utils.lib.sh

verbose=1

wait_for_db

wait_for_dbextension postgis

export PGPASSWORD=${POSTGRES_PASS}
psql -h db -U $POSTGRES_USER -d $POSTGRES_DB  <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    CREATE EXTENSION IF NOT EXISTS postgis_raster;
    CREATE EXTENSION IF NOT EXISTS postgres_fdw;
    CREATE EXTENSION IF NOT EXISTS unaccent;
    CREATE EXTENSION IF NOT EXISTS pgcrypto;
    CREATE EXTENSION IF NOT EXISTS hstore;
    CREATE EXTENSION IF NOT EXISTS pg_trgm;
EOSQL

touch ${script_home_dir}/sysfiles/db_initialized

_verbose_echo "${orange}Fin de l'initialisation de la base de données!${nocolor}"
