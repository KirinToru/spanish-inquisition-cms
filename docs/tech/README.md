# Spanish Inquisition CMS Technical Documentation

Welcome to the internal technical documentation for the **Internal Court Management System of the Spanish Inquisition** (Spanish Inquisition CMS).

## System Architecture

The system operates on a distributed client-server architecture designed for cross-platform environments:
- **Backend**: Built with Java 17 and Spring Boot framework, exposing REST endpoints.
- **Frontend**: Native client written in Holy C, engineered for ultra-responsive low-level interaction.
- **Database**: PostgreSQL 15 relational database managed via Docker Compose.

## Core Modules

1. **Heretic Registration**:
   - Manages heretic records, dossiers, affiliations, and sin tracking.
2. **Interrogation Management**:
   - Schedules interrogation sessions, assigns presiding inquisitors, tracks outcomes, and compiles transcripts.
3. **Interrogation Room Inventory**:
   - Oversees chambers, equipment assignments, capacity tracking, and operational maintenance.

## Documentation Index

- Backend API: Documented across Java package components under `com.example.api`.
- Database Schema: Defined via relational entity models and Docker setup.

## Documentation Resources & Artifacts

- **Doxygen Configuration**: [Doxyfile](Doxyfile).
- **Architecture Diagrams**: [Class Diagram](class_diagram.png).