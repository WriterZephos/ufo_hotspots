# Use the official image as a parent image
FROM ruby:latest

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . /application

# Change to the application's directory
WORKDIR /application

# Install dependencies
ENV BUNDLER_WITHOUT="development test"
ENV RAILS_ENV production

RUN bundle install \
	&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
	&& apt install -y nodejs

RUN chmod +x ./entrypoint.sh

# Start the application server
ENTRYPOINT ["./entrypoint.sh"]
