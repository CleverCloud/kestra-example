# Changelog

## [2026-10-15]

### Changed
- Engine: Java 23 (hardcoded base-image path `/opt/openjdk-bin-23.0.2_p7`) → Java 25 LTS (Temurin, installed by mise)
- Kestra: unpinned "latest" download (0.23.x era) → pinned 2.0.4 from the 2.0 LTS line (MAJOR), checksum-verified from the GitHub release
- MinIO storage plugin: `LATEST` (0.23.x) → pinned 1.2.12 (MAJOR), compatible with Kestra 2.0.4
- `config.yml`: `basicAuth` → `basic-auth` (the `enabled` flag is ignored since 0.24), MinIO storage keys moved to kebab-case with `port: 443` / `secure: true`, `kestra.url` replaces `micronaut.url`, PostgreSQL pool capped at 4 connections
- JVM now uses 75% of the instance memory (`-XX:MaxRAMPercentage=75`, overridable with `JAVA_OPTS`); XS flavor verified to work
- Bucket creation in the build is idempotent, so redeployments no longer fail
- `env.sh` and README deployment steps: `CC_DOMAIN` is now set on the application, `BUCKET_NAME` is derived from `.clever.json` instead of the first application of the organisation
- README normalized to the Clever Cloud example format

### Removed
- `kestra.plugins.defaults` (Process task runner for script plugins): removed upstream in Kestra 2.0; the README explains how to set the task runner per task

### Notes
- Kestra 2.0.5 and 2.0.6 held back: published less than 14 days ago
- storage-minio 1.2.13 held back: published less than 14 days ago
