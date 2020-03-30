#!/bin/bash

# Compile the assets
bundle exec rails assets:precompile

# Start the server
bundle exec rails server
