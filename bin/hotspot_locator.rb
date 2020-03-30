#!/usr/bin/env ruby
require './config/environment'
require 'io/console'   
puts "Running script in #{Rails.env} environment."



hotspots = [
  {latitude: 38.897663, longitude: -77.036575},
  {latitude: 35.26644, longitude: -116.07275},
  {latitude: 37.233333, longitude: -115.808333},
  {latitude: 28.404010, longitude: -81.576900},
  {latitude: 35.658340, longitude: -97.335490},
]

unless ARGV.length < 1
  ARGV.each do|a|
    reader = CsvReader.new
    puts "Processing file: #{Rails.root}#{a}"
    reader.read_from_path("#{Rails.root}/#{a}")
    sightings = reader.parse_lines.compact
    sightings.each(&:save)
  end
end

locator = HotspotLocator.new(hotspots,750)
all_sightings = UfoSighting.all
puts "\nCalculating results..."
in_range = locator.sightings_within_hotspot_range(all_sightings)
puts "#{in_range.count}/#{all_sightings.count} reported sightings are withing 750 miles of a hotspot."
puts "Press enter to print JSON results"
STDIN.getch
puts in_range.to_json