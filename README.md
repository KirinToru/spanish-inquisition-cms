# Spanish Inquisition CMS

A distributed client-server system for managing internal court records (heretic registrations, interrogations, and room inventory) of the Spanish Inquisition.

[![Java Backend CI](https://github.com/KirinToru/spanish-inquisition-cms/actions/workflows/backend.yml/badge.svg)](https://github.com/KirinToru/spanish-inquisition-cms/actions/workflows/backend.yml)
[![Java](https://img.shields.io/badge/Java-Backend-007396?style=flat-square&logo=java)](api/)
[![Holy C](https://img.shields.io/badge/Holy_C-Frontend-blue?style=flat-square)](app/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=flat-square&logo=postgresql)](api/docker-compose.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

## Tech Stack
- **Backend:** Java 17, Spring Boot 4
- **Frontend:** Holy C (GTK-3)
- **Database:** PostgreSQL 15 (Docker)

## Quick Start
1. **Database:** `docker compose -f api/docker-compose.yml up -d`
2. **Backend:** `cd api && ./gradlew bootRun` (or `.\gradlew.bat bootRun` on Windows)
3. **Frontend:** Run `app/basic_window.hc` in your Holy C environment

## Documentation & Contributing
- [Deployment Guide](docs/deploy/README.md)
- [Technical Architecture](docs/tech/README.md)
- [User Guide](docs/user/README.md)
- [Contributing Guidelines](CONTRIBUTING.md)
- [License](LICENSE)
