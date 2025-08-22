FROM ruby:3.2

WORKDIR /app
COPY . .

RUN gem install bundler && bundle install

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
