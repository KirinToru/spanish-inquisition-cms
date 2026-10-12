# Deployment & Build Guide

This document outlines deployment, build, and environment execution procedures for the **Internal Court Management System of the Spanish Inquisition** (Spanish Inquisition CMS).

---

## Prerequisites

Ensure the following tools are installed in your environment:
- **Docker & Docker Compose**: For containerized PostgreSQL database.
- **Java Development Kit (JDK 17+)**: For Spring Boot backend compilation and execution.
- **Gradle**: (Included via `gradlew` wrapper in `api/`).
- **Doxygen**: For generating technical HTML/LaTeX documentation (optional, required only for docs builds).

---

## 1. Database Provisioning (PostgreSQL)

The database runs in a containerized PostgreSQL 15 Alpine instance.

1. Navigate to the API configuration directory or reference the compose file directly:
   ```bash
   docker compose -f api/docker-compose.yml up -d
   ```
2. Verify container health:
   ```bash
   docker ps --filter "name=spanish_inquisition_db"
   ```
   - **Port**: `5433` (mapped from container `5432`)
   - **Database**: `spanish_inquisition`
   - **Credentials**: `postgres` / `mysecretpassword` (configured in `api/docker-compose.yml` and `api/src/main/resources/application.properties`)

To stop the database:
```bash
docker compose -f api/docker-compose.yml down
```

---

## 2. Backend Deployment (Spring Boot)

The backend provides the central REST API.

1. Navigate to the `api` directory:
   ```bash
   cd api
   ```
2. **Development / Local Run**:
   - Windows (PowerShell / CMD):
     ```powershell
     .\gradlew.bat bootRun
     ```
   - Linux / macOS:
     ```bash
     ./gradlew bootRun
     ```
3. **Production Build**:
   ```bash
   ./gradlew build -x test
   ```
   The executable JAR file will be generated in `api/build/libs/`.
4. **Health Check**:
   Once started, verify service availability at:
   ```http
   GET http://localhost:8080/ping
   ```

---

## 3. Frontend Client (Holy C)

The frontend is natively written in Holy C targeting low-level client environments:
- Source files are organized under `src/frontend/`.
- Run in target runtime or compatible TempleOS / Holy C environment.
- Configured to communicate with the backend REST endpoints on `http://localhost:8080`.

---

## 4. Documentation Generation (Doxygen)

API and architecture documentation can be generated locally using Doxygen.

1. Navigate to the technical documentation directory:
   ```bash
   cd docs/tech
   ```
2. Execute Doxygen against the configuration file:
   ```bash
   doxygen Doxyfile
   ```
3. View the generated documentation:
   Open `docs/tech/doxygen/html/index.html` in any web browser.

---

## References

- [Technical Documentation Hub](../tech/README.md)
- [Project Charter & Specification PDF](../Project_IO_1.pdf)
