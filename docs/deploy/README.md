# Deployment & Build Guide

## Prerequisites
- **Docker & Docker Compose** (PostgreSQL 15)
- **JDK 17+** (Spring Boot backend)
- **Holy C environment & GTK-3** (Frontend client)
- **Doxygen** (optional, for docs generation)

---

## 1. Database (PostgreSQL)
Start the PostgreSQL container:
```bash
docker compose -f api/docker-compose.yml up -d
```
- **Port:** `5433` (mapped to `5432`)
- **Database:** `spanish_inquisition`
- **Credentials:** `postgres` / `mysecretpassword`

Stop the database:
```bash
docker compose -f api/docker-compose.yml down
```

---

## 2. Backend (Spring Boot)
Run locally:
- **Linux / macOS:** `./gradlew bootRun` (inside `api/`)
- **Windows:** `.\gradlew.bat bootRun` (inside `api/`)

Build production JAR:
```bash
./gradlew build -x test
```
*(JAR located in `api/build/libs/`)*

### Run via Pre-built CI Artifact (No Gradle required)
If you do not have Gradle or a full dev setup locally:
1. Open the GitHub repository and navigate to the **Actions** tab.
2. Select the latest successful run of **Java Backend CI**.
3. Under **Artifacts**, download `api-build-jar.zip` and extract the `.jar` file.
4. Run directly:
   ```bash
   java -jar api-0.0.1-SNAPSHOT.jar
   ```

Verify health:
```http
GET http://localhost:8080/ping
```

---

## 3. Frontend Client (Holy C)
Source files reside in `app/`:
- Entry point: `app/basic_window.hc`
- Required assets: `app/font.ttf`, `app/music.wav`
- Run using a compatible Holy C runtime (such as `holyc-lang`) with GTK-3 support.
- Communicates with the Spring Boot backend on `http://127.0.0.1:8080` via native TCP sockets.

---

## 4. Technical Docs (Optional)
Generate Doxygen docs:
```bash
cd docs/tech && doxygen Doxyfile
```
Open `docs/tech/doxygen/html/index.html`.
