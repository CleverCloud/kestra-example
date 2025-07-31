
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

# Bucket name must be unique, let's base it on app name,
# replacing '_' with '-' to make it valid S3 bucket name
clever env set BUCKET_NAME $(clever applications -j | jq -r '.[0].app_id' | tr '_' '-')-kestra

clever env set BASIC_AUTH_USERNAME $USERNAME
clever env set BASIC_AUTH_PASSWORD $PASSWORD

clever deploy