# FastAPI Calculator with PostgreSQL and pgAdmin

## Project Overview

This Module 9 project uses Docker Compose to run three services:

- **FastAPI:** A Python calculator web application.
- **PostgreSQL:** A database for storing users and calculations.
- **pgAdmin:** A web interface for managing PostgreSQL.

The assignment demonstrates creating tables, inserting records, querying data, joining tables, updating records, and deleting records.

## Technologies

- Python 3.14
- FastAPI
- Uvicorn
- Jinja2
- PostgreSQL 18
- pgAdmin 4
- Docker and Docker Compose

## Project Structure

```text
sql_pgadmin/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .gitignore
├── requirements.txt
├── main.py
├── app/
│   └── operations/
│       └── __init__.py
├── templates/
│   └── index.html
├── sql/
│   └── assignment.sql
└── README.md
```

## Prerequisites

- Docker Engine or Docker Desktop installed and running.
- Docker Compose available through `docker compose`.
- Ports `8000`, `5432`, and `5050` available.

Python is provided inside the application container. A local Python installation is not required to run the Docker services.

## Clone the Repository

Verify that Git is installed:

```bash
git --version
```

Clone the project:

```bash
git clone git@github.com:rajaramnpatil/sql_pgadmin.git
```

Open the cloned project directory:

```bash
cd sql_pgadmin
```

## Initial Project Setup

Start Docker Desktop, or ensure Docker Engine is running on Linux.

Verify Docker and Docker Compose:

```bash
docker --version
docker compose version
docker info
```

Confirm the project folder contains:

- `Dockerfile`
- `docker-compose.yml`
- `requirements.txt`
- `main.py`
- `templates/index.html`
- `sql/assignment.sql`

The application Dockerfile uses Python 3.14:

```dockerfile
FROM python:3.14-slim-bookworm
```

Docker installs the Python dependencies during the image build. You do not need to create a local virtual environment or install the packages manually.

Ensure ports `8000`, `5432`, and `5050` are available.

## Build and Start the Services

Open a terminal in the project directory containing `docker-compose.yml`.

Build the application image and start all services in the background:

```bash
docker compose up -d --build
```

Check the status of the containers:

```bash
docker compose ps -a
```

The PostgreSQL container should become healthy. FastAPI and pgAdmin start after the database health check succeeds.

## Access the Services

| Service | Container Name | Address |
|---|---|---|
| FastAPI Calculator | fastapi_calculator | http://localhost:8000 |
| FastAPI Documentation | fastapi_calculator | http://localhost:8000/docs |
| Application Health | fastapi_calculator | http://localhost:8000/health |
| pgAdmin | pgadmin | http://localhost:5050 |
| PostgreSQL | postgres_db | localhost:5432 |

These addresses assume Docker runs on the same computer as your browser.

### pgAdmin Login

| Field | Value |
|---|---|
| Email | admin@example.com |
| Password | admin |

### PostgreSQL Connection from pgAdmin

| Field | Value |
|---|---|
| Server Name | Calculator Database |
| Host Name / Address | db |
| Port | 5432 |
| Maintenance Database | fastapi_db |
| Username | postgres |
| Password | postgres |

The hostname `db` is the Docker Compose service name. pgAdmin uses it to reach PostgreSQL through the shared Docker network.

These credentials are intended for the local assignment environment.

## View Service Logs

View recent logs for all services:

```bash
docker compose logs --tail=50
```

Follow the application logs:

```bash
docker compose logs -f web
```

Press `Ctrl+C` to stop following logs. The services continue running in the background.

## Database Tables and Relationships

The assignment uses two related tables:

| Table | Purpose |
|---|---|
| users | Stores usernames, email addresses, and creation times |
| calculations | Stores operations, operands, results, and the associated user |

### Primary Keys

- `users.id` uniquely identifies each user.
- `calculations.id` uniquely identifies each calculation.

### Foreign Key

- `calculations.user_id` references `users.id`.
- This ensures each calculation belongs to an existing user.

### One-to-Many Relationship

One user can have many calculations, but each calculation belongs to one user.

The foreign key uses `ON DELETE CASCADE`. Deleting a user also deletes that user's calculations.

The SQL script is stored in `sql/assignment.sql`.

## Data Persistence

The project uses named Docker volumes:

| Volume | Purpose |
|---|---|
| postgres_data18 | Stores PostgreSQL database files |
| pgadmin_data | Stores pgAdmin settings and server registrations |

PostgreSQL 18 uses the volume mount path `/var/lib/postgresql`.

Database records and pgAdmin settings remain available when containers are removed and recreated using the same Compose project and volumes.

## Shut Down After Completing SQL Operations

After completing the SQL operations and capturing your screenshots, stop and remove the containers and Compose network:

```bash
docker compose down
```

This preserves the named volumes, including database records and pgAdmin settings.

Do not add `-v` unless you intentionally want to delete the named volumes and their data.

To start the services again:

```bash
docker compose up -d
```

If you changed the Dockerfile or Python dependencies, rebuild when starting:

```bash
docker compose up -d --build
```

## Author
Rajaram Patil
Fall 2026 semester, MS in computer Science @NJIT
