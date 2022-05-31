#!/bin/bash
set -eo pipefail
VAULT_ROOT_ROLE_NAME="vault_root_role"
VAULT_DATABASE_ROLE_NAME="vault_database_role"
VAULT_DATABASE_AUTH_ROLE="${RDS_CLUSTER_NAME}-role"
CREATION_STATEMENTS=$(
    cat <<SQL
  DO \$\$
  DECLARE
    skema record;
  BEGIN
    CREATE ROLE "{{name}}" WITH LOGIN ENCRYPTED PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;
    GRANT $VAULT_DATABASE_ROLE_NAME TO "{{name}}";
    GRANT "{{name}}" TO $VAULT_ROOT_ROLE_NAME;
    ALTER DEFAULT PRIVILEGES FOR ROLE "{{name}}" GRANT ALL ON TABLES TO $VAULT_DATABASE_ROLE_NAME;
    ALTER DEFAULT PRIVILEGES FOR ROLE "{{name}}" GRANT ALL ON FUNCTIONS TO $VAULT_DATABASE_ROLE_NAME;
    ALTER DEFAULT PRIVILEGES FOR ROLE "{{name}}" GRANT ALL ON SEQUENCES TO $VAULT_DATABASE_ROLE_NAME;
    ALTER DEFAULT PRIVILEGES FOR ROLE "{{name}}" GRANT ALL ON TYPES TO $VAULT_DATABASE_ROLE_NAME;

    FOR skema IN SELECT schema_name FROM information_schema.schemata
      WHERE schema_name NOT IN ('pg_catalog', 'information_schema')
    LOOP
      execute format ('GRANT ALL ON ALL TABLES IN SCHEMA %s TO %s;', skema.schema_name, '$VAULT_DATABASE_ROLE_NAME');
      execute format ('GRANT ALL ON ALL FUNCTIONS IN SCHEMA %s TO %s;', skema.schema_name, '$VAULT_DATABASE_ROLE_NAME');
      execute format ('GRANT ALL ON ALL SEQUENCES IN SCHEMA %s TO %s;', skema.schema_name, '$VAULT_DATABASE_ROLE_NAME');
    END LOOP;
  END;
  \$\$;
SQL
)

echo "CREATION_STATEMENTS: \n $CREATION_STATEMENTS"
