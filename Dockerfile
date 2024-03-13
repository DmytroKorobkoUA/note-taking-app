# Use the official Ruby 3.0.0 image from Docker Hub
FROM ruby:3.0.0

# Set environment variables
ENV RAILS_ROOT /app
ENV LANG C.UTF-8
ENV DISABLE_IPV6=true
ENV REDIS_URL=redis://127.0.0.1:6379

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs default-libmysqlclient-dev

# Set up the application directory
RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

# Copy the application code
COPY . .

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
