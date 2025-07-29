
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

clever env set BASIC_AUTH_USERNAME $USERNAME
clever env set BASIC_AUTH_PASSWORD $PASSWORD

clever deploy