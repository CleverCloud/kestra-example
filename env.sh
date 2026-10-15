#!/usr/bin/env bash
# Deploy Kestra on Clever Cloud. Run from the root of this repository.
# Required: APP_NAME, USERNAME (an email address), PASSWORD. Optional: ORGANISATION.
set -euo pipefail
ORG_OPT=${ORGANISATION:+--org $ORGANISATION}

# Step 1: Create a Linux application
clever create --type linux $ORG_OPT "$APP_NAME"
clever scale --flavor XS

# Step 2: Create required add-ons
# - PostgreSQL database for queue and repository (minimum XXS plan, XS or higher recommended)
# - Cellar (S3-compatible) for internal storage
clever addon create postgresql-addon --plan xxs_sml $ORG_OPT "$APP_NAME-pg"
clever addon create cellar-addon $ORG_OPT "$APP_NAME-s3"

# Step 3: Link add-ons to your application
clever service link-addon "$APP_NAME-pg"
clever service link-addon "$APP_NAME-s3"

# Step 4: Configure environment variables
# Bucket name must be unique: base it on the app ID, replacing '_' with '-'
clever env set BUCKET_NAME "$(jq -r '.apps[0].app_id' .clever.json | tr '_' '-')"
clever env set CC_DOMAIN "$(clever domain | grep -o '[a-z0-9.-]*cleverapps.io' | head -1)"
clever env set BASIC_AUTH_USERNAME "$USERNAME"
clever env set BASIC_AUTH_PASSWORD "$PASSWORD"

# Step 5: Deploy
clever deploy
