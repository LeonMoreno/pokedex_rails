# 💡 About the project

 This project is an enhanced second version of the Pokedex project originally created as part of the PETAL onboarding. The Restful API exposes Pokemon information to potential clients, allowing queries and manipulations through well-defined endpoints.
 
 ## Improvements

- Using my own docker-compose file to manage PostgreSQL and pgAdmin as services.
- Added basic authentication using JSON Web Tokens (JWT) with the `jwt` gem.
- Enhanced security with password hashing using the `bcrypt` gem.
- Routes are defined and managed using the `grape` gem, which provides a simple DSL for creating RESTful APIs in Ruby.
- Implemented serializers with `active_model_serializers` and `grape-active_model_serializers`.
- Pagination is handled with the `will_paginate` gem.
- Testing is performed using the `rspec` gem, ensuring reliability and correctness of the application.

 # Routes

The API provides 8 routes, all of which can be tested using the Postman/Bruno collection:

## Pokedex Routes

- **Index**: Retrieves all Pokemon data.
  - Endpoint: `localhost:3000/api/v1/pokemons`

- **Show**: Retrieves data for a specific Pokemon by ID.
  - Endpoint: `localhost:3000/api/v1/pokemons/:id`

- **Search**: Allows searching for Pokemon by their name.
  - Endpoint: `localhost:3000/api/v1/search?name=name`

- **Create**: Adds a new Pokemon to the database.
  - Endpoint: `POST localhost:3000/api/v1/pokemons`

- **Update**: Modifies the information of an existing Pokemon.
  - Endpoint: `PATCH localhost:3000/api/v1/pokemons/:id`

- **Delete**: Removes a Pokemon from the database.
  - Endpoint: `DELETE localhost:3000/api/v1/pokemons/:id`


## Authentication Routes: User Registration and Login

To access the create, update, and delete routes for the Pokedex, authentication via token is required.

- **Create User**: Registers a new user in the system.
  - Endpoint: `POST localhost:3000/api/v1/users`

- **Login**: Authenticates a user and generates a JWT token for further access.
  - Endpoint: `POST localhost:3000/api/v1/auth/login`


# How to Run

Follow these steps to test the application:

1) Start Docker service:

    `docker compose up -d`

2) Create the database by running the following command:

    `rails db:create`

3) Run the migrations to set up the database schema:

    `rails db:migrate`

4) Seed the database with initial data if necessary:

    `rails db:seed`

5) Launch the Rails server:

     `rails s`

# Tests

![Screenshot from 2024-06-11 14-00-23](https://github.com/LeonMoreno/pokedex_rails/assets/88601147/7c08c9e3-ff1e-4c20-a4b5-6f956a996510)
