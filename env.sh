
# Step 1: Create a Linux application
clever create --type linux $APP_NAME -o $ORGANISATION

# Step 2: Create required add-ons 
# - PostgreSQL database for workflow storage (minimum XXS plan required, XS or higher recommended)
clever addon create postgresql-addon --plan xxs_sml -o $ORGANISATION $APP_NAME-pg
clever addon create cellar-addon -o $ORGANISATION $APP_NAME-s3

# Step 3: Link add-ons to your application
clever service link-addon $APP_NAME-pg
clever service link-addon $APP_NAME-s3

# Step 4: Configure environment variables
eval "$(clever env -F shell)"
export CC_DOMAIN=`clever domain`

clever env set DATASOURCES_POSTGRES_URL "jdbc:postgresql://$POSTGRESQL_ADDON_HOST:$POSTGRESQL_ADDON_PORT/$POSTGRESQL_ADDON_DB"
clever env set DATASOURCES_POSTGRES_USERNAME $POSTGRESQL_ADDON_USER
clever env set DATASOURCES_POSTGRES_PASSWORD $POSTGRESQL_ADDON_PASSWORD
clever env set DATASOURCES_POSTGRES_DRIVER_CLASS_NAME "org.postgresql.Driver"

clever env set KESTRA_STORAGE_S3_ENDPOINT "https://$CELLAR_ADDON_HOST"
clever env set KESTRA_STORAGE_S3_ACCESS_KEY $CELLAR_ADDON_KEY_ID
clever env set KESTRA_STORAGE_S3_SECRET_KEY $CELLAR_ADDON_KEY_SECRET
clever env set KESTRA_STORAGE_S3_BUCKET kestra
