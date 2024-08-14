# Rails Template Project

## Overview

Welcome to the Rails App Template! This project is a starting point for Rails development, providing a basic setup with essential configurations and gems. It aims to help developers quickly get up and running with Rails and serve as a foundation for future enhancements and best practices.

## Features

- **Rails 7.2**: The latest version of Rails for modern web development.
- **HTTPS Support**: Configured with TLS certificates for secure communication.
- **Docker Support**: Includes a Dockerfile to containerize the application, with TLS certificates and database migration handling.
- **ActionCable**: Real-time features with WebSockets support.
- **Minitest**: A testing framework for writing tests.
- **FriendlyId**: Enhances the default Rails ID handling with user-friendly URLs.
- **Faker**: Generates fake data for development and testing.
- **Rubocop**: Provides code linting and formatting with support for performance and Rails-specific rules.

## Getting Started

### Prerequisites

- Ruby (version required by Rails 7.2 - here's a [guide on how to install Ruby on your machine](https://www.ruby-lang.org/en/documentation/installation/))
- Rails 7.2 - here's a [guide on how to install Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails)
- Docker ([Download docker desktop](https://www.docker.com/products/docker-desktop/))

### Setup

1. **Clone the repository:**

    ```bash
    git clone https://github.com/kavignon/rails-app-template.git
    cd rails-app-template
    ```

2. **Install dependencies:**

    ```bash
    bundle install
    ```

3. **Run the Rails server:**

    ```bash
    rails server
    ```

   By default, the server runs with HTTPS enabled. You can access it at `https://localhost:3000`.

### Docker

To run the application inside a Docker container:

1. **Build the Docker image:**

    ```bash
    docker build -t rails-app-template .
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
    docker run -p 3000:3000 --env SECRET_KEY_BASE=mysecretkey rails-app-template
    ```

### Testing

To run tests using Minitest:

```bash
rails test
```
