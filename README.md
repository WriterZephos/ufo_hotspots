# README

## How to build and run the app

## Overview
* Environment setup: I had a brand new linux partition I wanted to use for this (my only other personal dev environment was windows and I have had issues developing in ruby there) but I am not a huge linux guy so that presented some challenges. I needed to install quite a few things, but I didn't count that as time working on the app. The only notable technology I used besides the obvious (ruby/rails/mysql) was Visual Studio Code with my favorite extensions.
* Initializing the app: I just ran "rails new ufo_hotspots -d mysql".
* Test driven developement: I decided to use TDD, even though it would slow me down, because I would rather write solid, correct code than ship a bug. I ended up only writing two services along with a command line script that uses them, and a controller to render this file so the web app actually did something.
* The services I created are:
  1. hotspot_locator.rb: a service that handles all the distance finding and retrieval of sightings within range of a hotspot.
  2. csv_reader.rb: a service that could read a csv file and parse the contents, and return them as ufo sightings that hotspot_locator would understand.

## Database schema

* My db schema only has one table, ufo_sightings with the columns specified by the coding challenge.

## Challenges
* I had trouble getting access for the app to mysql, because the user could only login with sudo.
* My tests could not find my service classes for some reason and I had to restart spring to fix it.
* TDD is time-consuming, so I didn't accomplish as much as I wanted. What remains to be done are things I am confident I could do with a bit more time. Web applications are what I have done the most in Ruby, so controllers, routes, erb templates and models are all within my wheelhouse.
* I accidentally lost a lot of changes at one point by running the wrong git command... luckily I still had my files open in my IDE and could resave them. I committed each change separately again so that my workflow would still be evident in my git history.
* At first I tried using the Geometry gem, but it gave me errors and I didn't want to risk losing a lot of time going down a rabit hole, so I scrapped it.
* I have only used CSV in ruby once or twice, so I had to read up on that.
* I wasn't sure what styleguide to follow (seattle or standard).
* I ran into a lot of issues with getting docker-compose to play nicely with my environment.

## Assumptions
* One degree in lattitude or longitude is 69 miles, even though it actually varies slightly (according to google).

## Next steps (assume these would be done with TDD)
1. Create a controller and controller action to handle ufo_sighting data posts, call the HotspotLocator and return the result as JSON. Add routes to routes.rb.
2. Generate a controller action for an API to retrieve stored ufo sighting withing range of hotspots.
3. Generate a ufo_sightings controller for basic CRUD operations, with assciated views.
4. Generate a controller, index action, and view to show ufo sightings as they come in. Implement an auto refresh with javascript to make it real-time.
5. Do more, and more, and more...

