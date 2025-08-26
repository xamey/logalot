Rails.application.reloader.to_prepare do
  Rails.event.subscribe(Subscribers::Datadog.new)

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
end
