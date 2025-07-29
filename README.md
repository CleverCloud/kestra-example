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

### Architecture Overview

Kestra consists of several core components that work together:

- **Executor**: Manages the execution lifecycle of data workflows
- **Scheduler**: Initiates workflows based on trigger events
- **Worker**: Executes individual tasks within a flow
- **Indexer**: (Optional) Enhances data retrieval by indexing workflow metadata
- **Webserver**: Provides the UI and API access for workflow management

## Important Notes

- **Database Requirements**: Kestra requires a PostgreSQL database for storing workflow metadata and execution history. For production environments, XS plan or larger is strongly recommended.
- **Storage Requirements**: Kestra needs persistent storage for workflow files, logs, and temporary data. A filesystem bucket is required.
- **Memory Requirements**: Kestra is a Java-based application that requires adequate memory allocation. Consider using at least S plan for production workloads.
- **Scaling**: The configuration provided is suitable for small to medium workloads. For higher demands, consider upgrading your database and application plans.

### User Authentication

Kestra provides built-in user management and authentication:

1. **First-time setup**:
   - When you first access your Kestra instance, you'll be prompted to create an admin account
   - Follow the on-screen instructions to set up your username, email, and password

2. **Managing users**:
   - After initial setup, you can manage additional users through the Kestra UI
   - Navigate to Administration > Users to add or modify user accounts

## Post-Deployment

1. Once deployed, access your Kestra instance at `https://<YOUR_DOMAIN_NAME>/`
2. Complete the initial setup wizard to create your admin account
3. Explore the tutorial flows and start creating your own workflows!
4. Check out the extensive plugin library with 600+ available integrations

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
