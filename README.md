# Note Taking App

This is a test task for creating an API with basic authentication via JWT for managing notes.

## Usage

1. **Clone the project code**
   ```bash
   git clone https://github.com/DmytroKorobkoUA/note-taking-app.git
   ```
2. **Install dependencies:**
    ```bash
    bundle install
    yarn install
    ```
3. **Set up database configuration:**
   - Configure `config/database.yml` with your database settings.
4. **Start the Rails server:**
    ```bash
    rails s
    ```
5. **Create a default user:**
    ```bash
    bundle exec rake users:create_default
    ```
   This will create a default user with the following attributes:
   - Username: 'admin'
   - Email: 'admin@user.com'
   - Password: 'StrongPassword!'
   - Password Confirmation: 'StrongPassword!'
6. **Import default notes from JSON mock:**
    ```bash
    bundle exec rake notes:import
    ```
7. **Start Resque for background jobs:**
    ```bash
    QUEUE=* bundle exec rake resque:work
    ```
8. **Start the Resque scheduler for fetching notes:**
    ```bash
    bundle exec rake resque:scheduler
    ```

## Docker Setup

1. **Clone the project code**
2. **Run Docker Compose:**
    ```bash
    docker-compose up --build
    ```

## Testing

To run tests, execute:
 ```bash
 bundle exec rspec
 ```

## Endpoints
  **Index:**
 ```bash
 GET /v1/notes
 ```
 - Get a list of notes with search parameters if needed.

  **Show:**
 ```bash
 GET /v1/notes/:id
 ```
 - Get a specific note.

  **Create:**
 ```bash
 POST /v1/users/notes
 ```
 
 - Create a new note.
 - Params: :title, :content
 - Authentication token needed.

  **Update:**
 ```bash
 PATCH /v1/users/notes/:id
 ```
 - Update an existing note.
 - Params: :title, :content
 - Authentication token needed.

  **Destroy:**
 ```bash
 DELETE /v1/users/notes/:id/destroy
 ```
 - Delete a note.
 - Authentication token needed.

  **Authentication:**
 ```bash
 POST /v1/auth/login
 ```
 
 - Authenticate a user.
 - Params: :username, :password



