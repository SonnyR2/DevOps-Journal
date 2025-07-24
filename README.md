# Journal Project

My journal project to log daily work, struggles, and intentions. 
Designed for developers and learners to reflect and track progress.


## Prerequisites

- Terraform installed ([install guide](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- AWS CLI configured with appropriate permissions
- SSH key pair for access to the API server
- GitHub account with access to the API repository
- PostgreSQL user and database ready (can be provisioned via Terraform or externally)


## API Server Implentation

1. **Clone this repository:**
   ```bash
   git clone <this_repo_url>
   cd <this_repo_directory>
   ```
2. **Apply Terraform IaC**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```
3. **Setup API Server**
   - SSH into server instance
   ```bash
   git clone git@github.com:<your_username>/<your_repo>.git
   python -m venv venv
   source venv/bin/activate or venv\Scripts\activate on Windows
   pip install -r requirements.txt
   ```
   - create a .env file with 
   ```bash
   POSTGRES_HOST=<replace_with_your_private_ip>
   POSTGRES_PORT=5432
   POSTGRES_USER=<name_of_postgres_user>
   POSTGRES_PASSWORD=<password_of_user>
   POSTGRES_DB=<name_of_db>
   DATABASE_URL=postgresql://<name_of_postgres_user>:<password_of_user>@<replace_with_your_private_ip>:5432/<name_of_db>
   ```
4. **Setup PostgresDB**
   - SSM into the database server
   - sudo apt install -y postgresql postgresql-contrib

   - Create your database table in postgres
   ```sql
   CREATE TABLE entries (
    id TEXT PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
   );
   ```
5. **Test API Server Connection to DB**
   - run application in API Server
   ```bash
   fastapi dev main.py
  curl -X POST http://localhost:8000/entries \
    -H "Content-Type: application/json" \
    -d '{"example": "example"}'
   ```
### Example Entry
```json
{
  "work": "Worked on FastAPI routes",
  "struggle": "Entries not created",
  "intention": "Fix configuration"
}
```
## Development Tasks

### API Implementation

1. Endpoint in `journal_router.py` have been updated:
   - GET /entries - List all journal entries
   - GET /entries/{entry_id} - Get single entry
   - DELETE /entries/{entry_id} - Delete specific entry

### Logging Setup

1. Basic console logging in `main.py`:
   - Configure basic logging
   - Set logging level to INFO
   - Add console handler

### Data Model Improvements

1. Entry model in `models/entry.py` has been added to `services/entry_service.py`:
   - Added basic field validation rules
   - Added input data sanitization
   - Added schema version tracking

### Development Environment

1. Configure cloud provider CLI in `.devcontainer/devcontainer.json`:
   - AWSCLI configured along with env variables


### Data Schema

The journal entry data model is structured as follows:

| Field       | Type      | Description                                | Validation                   |
|-------------|-----------|--------------------------------------------|------------------------------|
| id          | string    | Unique identifier for the entry (UUID)     | Auto-generated UUID          |
| work        | string    | What did you work on today?                | Required, max 256 characters |
| struggle    | string    | What's one thing you struggled with today? | Required, max 256 characters |
| intention   | string    | What will you study/work on tomorrow?      | Required, max 256 characters |
| created_at  | datetime  | Timestamp when the entry was created       | Auto-generated UTC timestamp |
| updated_at  | datetime  | Timestamp when the entry was last updated  | Auto-updated UTC timestamp   |

All text fields sanitizatized to prevent injection attacks and ensure data quality. The schema includes version tracking to handle potential future changes to the data structure.

### API Endpoints

1. **GetEntries:** Returns a JSON list of all journal entries - IMPLEMENTED
2. **GetEntry:** Returns a specific journal entry by ID - IMPLEMENTED
3. **DeleteEntry:** Removes a specific journal entry - IMPLEMENTED
4. **CreateEntry:** Creates a new journal entry - IMPLEMENTED
5. **UpdateEntry:** Updates an existing journal entry - IMPLEMENTED
6. **DeleteAllEntries:** Removes all journal entries - IMPLEMENTED