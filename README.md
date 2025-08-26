# Logalot

A minimal Docker-compose setup with a Rails app to test Datadog log collection with Structured Event Reporting by generating logs every 10 seconds.

More infos on Structured Event Reporting [here](https://github.com/rails/rails/pull/55334/files#diff-b62185ac41b8fd41482706d038907fd8b570b2aaa3ad535cddb409173827bb03).

### Prerequisites

- Docker and Docker Compose
- Datadog API key

### Setup

1. Set your Datadog API key in a .env:

   ```bash
   DD_API_KEY=your_datadog_api_key_here
   ```

2. Start the application:

   ```bash
   docker-compose up -d --build
   ```

## How it works

The application runs a background thread that logs an UserCreated event every 10 seconds:

```ruby
# config/initializers/logalot.rb
Thread.new do
  loop do
    user = {
      id: rand(10000),
      type: rand(10) % 2 == 0 ? "User" : "Admin"
    }

    event = Events::User::UserCreated.new(user)
    Rails.event.notify(event)

    sleep 10
  end
end
```

## Configuration

### Datadog agent

The Datadog agent is configured to:

- Collect all container logs
- Exclude its own logs
- Use EU Datadog site (`datadoghq.eu`)
- Monitor the Rails application container

## License

This project is open source and available under the [MIT License](LICENSE).
