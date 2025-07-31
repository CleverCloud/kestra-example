![Clever Cloud logo](/github-assets/clever-cloud-logo.png)

# Kestra on Clever Cloud

[![Kestra.io - Workflow Orchestration](https://img.shields.io/badge/Kestra.io-Workflow%20Orchestration-blue)](https://kestra.io)
[![Clever Cloud - PaaS](https://img.shields.io/badge/Clever%20Cloud-PaaS-orange)](https://clever-cloud.com)

## Overview

This repository provides a complete guide for deploying [Kestra](https://kestra.io/) - a powerful workflow orchestration and scheduling platform - on [Clever Cloud](https://clever-cloud.com), a European PaaS provider.

Kestra is an event-driven, language-agnostic orchestration platform that allows you to manage millions of workflows declaratively in code. It supports 600+ plugins and can orchestrate business logic in any language, making it a versatile alternative to Airflow, VMware vRealize Automation, and Rundeck. By deploying on Clever Cloud, you get a reliable, scalable hosting solution with minimal maintenance overhead.

## Prerequisites

- A [Clever Cloud](https://www.clever-cloud.com/) account
- [Clever Tools CLI](https://github.com/CleverCloud/clever-tools) installed and configured
- Basic familiarity with command line operations
- A domain name (optional, but recommended for production use)

## Deployment Guide

### Before You Begin

Before starting the deployment process, you'll need to decide on:

- **Application Name**: Choose a unique name for your Kestra application (e.g., `my-kestra-app`)
- **Domain Name**: Optionally, choose a domain name for your application

You'll use these values throughout the deployment process. In the commands below, replace:
- `<APP_NAME>` with your chosen application name
- `<YOUR_DOMAIN_NAME>` with your domain name (if applicable)
- `<USERNAME>` with your chosen username for Kestra authentication
- `<PASSWORD>` with your chosen password for Kestra authentication

## Important Notes

Kestra offers many configuration options and customization. There are three main components that need to be configured during the initial setup:

### Core Configuration Components

- **Internal Storage**: Used for storing workflow files, execution logs, and temporary data
  - *This deployment uses*: **Clever Cloud Cellar** (S3-compatible storage) configured as MinIO
  - *Bucket creation*: Automatically handled during the build process using s3cmd
  
- **Queue**: Manages task execution queuing and coordination between Kestra components
  - *This deployment uses*: **Clever Cloud PostgreSQL** instance
  
- **Repository**: Stores workflow definitions, metadata, and execution history
  - *This deployment uses*: **Clever Cloud PostgreSQL** instance (same as Queue)

### Deployment Considerations

- **Database Requirements**: PostgreSQL database serves both Queue and Repository functions. For production environments, XS plan or larger is strongly recommended.
- **Storage Requirements**: Cellar (S3-compatible) storage handles internal file storage, logs, and temporary data.
- **Memory Requirements**: Kestra is a Java-based application that requires adequate memory allocation. Consider using at least S plan for production workloads.
- **Scaling**: The configuration provided is suitable for small to medium workloads. For higher demands, consider upgrading your database and application plans.

### User Authentication

Kestra community edition uses basic authentication configured through environment variables:

1. **Authentication Setup**:
   - Basic authentication is enabled in the configuration with credentials set via environment variables
   - The username and password are configured using `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD` environment variables
   - These credentials are set during deployment using the values you specify for `<USERNAME>` and `<PASSWORD>`

2. **Accessing Kestra**:
   - When you access your Kestra instance, you'll be prompted for the username and password
   - Use the credentials you configured during the deployment process

## Deployment Steps

### Using Clever Tools CLI

Follow these steps to deploy Kestra on Clever Cloud using the command line:

```bash
# Step 1: Create a Linux application
clever create --type linux <APP_NAME> 

# Step 2: Create required add-ons
# - PostgreSQL database for workflow storage (minimum XXS plan required, XS or higher recommended)
clever addon create postgresql-addon --plan xxs_sml <APP_NAME>-pg
clever addon create cellar-addon <APP_NAME>-s3

# Step 3: Link add-ons to your application
clever service link-addon <APP_NAME>-pg
clever service link-addon <APP_NAME>-s3

# Step 4: Configure environment variables
eval "$(clever env -F shell)"
export CC_DOMAIN=`clever domain`

# Configure S3 bucket name (converts underscores to hyphens for S3 compatibility)
clever env set BUCKET_NAME $(clever applications -j | jq -r '.[0].app_id' | tr '_' '-')

clever env set BASIC_AUTH_USERNAME <USERNAME>
clever env set BASIC_AUTH_PASSWORD <PASSWORD>

# Step 5: Deploy your application
clever deploy
```

## Post-Deployment

1. Once deployed, access your Kestra instance at `https://<YOUR_DOMAIN_NAME>/`
2. Explore the tutorial flows and start creating your own workflows!
3. Check out the extensive plugin library with 600+ available integrations

## Troubleshooting

If you encounter issues:

1. Check the application logs: `clever logs`
2. Verify all environment variables are correctly set: `clever env`
3. Ensure the add-ons are properly linked: `clever service status`
4. Monitor memory usage as Kestra can be memory-intensive
5. Check database connectivity and performance

## Key Features

- **Language Agnostic**: Write tasks in any programming language
- **Event-Driven**: React to file changes, API calls, schedules, and more
- **Rich Plugin Ecosystem**: 600+ plugins for various integrations
- **Visual Workflow Editor**: Build workflows with a user-friendly interface
- **Real-time Monitoring**: Track execution status and performance metrics
- **Version Control**: Manage workflow versions and deployments
- **Parallel Execution**: Run tasks concurrently for better performance

## Contributing

Contributions to improve this deployment example are welcome! Please feel free to submit pull requests or open issues for any enhancements or bug fixes.

## License

This example is provided under the terms of the MIT license.
