# Shoes Flash Sales

## Overview
This is a sample sandbox of an e-commerce platform allowing users to come and buy shoes.

## Features

- **Rails 7.2**: The latest version of Rails for modern web development.
- **HTTPS Support**: Configured with TLS certificates for secure communication.
- **Docker Support**: Includes a Dockerfile to containerize the application, with TLS certificates and database migration handling.
- **ActionCable**: Real-time features with WebSockets support.
- **Minitest**: A testing framework for writing tests.
- **Rubocop**: Provides code linting and formatting with support for performance and Rails-specific rules.

## Getting Started

### Prerequisites

- Ruby (version required by Rails 7.2 - here's a [guide on how to install Ruby on your machine](https://www.ruby-lang.org/en/documentation/installation/))
- Rails 7.2 - here's a [guide on how to install Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails)
- Docker ([Download docker desktop](https://www.docker.com/products/docker-desktop/))

### Setup

1. **Clone the repository:**

    ```bash
    git clone https://github.com/kavignon/shoe-flash-sales
    cd shoe-flash-sales
    ```

2. **Install dependencies:**

    ```bash
    bundle install
    ```

3. **Setting up the database:**

   ```bash
    rails db:create
    ```

   ```bash
    rails db:migrate
    ```

   ```bash
    rails db:seed
    ```

4. **Run the Rails server:**

    ```bash
    rails server # or RAILS_ENV=production rails server if you prefer running in production mode
    ```

   By default, the server runs with HTTPS enabled. You can access it at `https://localhost:3000`.

### Docker

To run the application inside a Docker container:

1. **Build the Docker image:**

    ```bash
    docker build -t shoe-flash-sales . # append --no-cache to force Docker to do clean builds.
    ```

2. **Define SECRET_KEY_BASE:**

   Use the following command

   ```bash
    rails secret
    ```

   Capture the text value in your terminal.

   Export your Rails secret as an environment variable such as

   ```bash
    export SECRET_KEY_BASE=mysecretkey
    ```

   __when exporting in your Terminal, the environment variable won't be available next time you create a Terminal instance. You could add the variable in your .bashprofile or define a .env file in the repository.__

4. **Run the container:**

    ```bash
    docker run -p 3000:3000 --env SECRET_KEY_BASE=mysecretkey shoe-flash-sales
    ```

### Testing

To run tests using Minitest:

```bash
rails test
```
