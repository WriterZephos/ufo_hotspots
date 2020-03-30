class HotspotLocator

  def initialize(hotspots = [], range = 0)
    @hotspots = hotspots
    @range = range
  end

  def evaluate_distance(sighting_x, sighting_y)
    longitude_dist = sighting_x[:longitude] - sighting_y[:longitude]
    latitude_dist = sighting_x[:latitude] - sighting_y[:latitude]
    Math.sqrt (longitude_dist * longitude_dist) + (latitude_dist * latitude_dist)
  end

  def evaluate_distance_miles(sighting_x, sighting_y)
    69 * evaluate_distance(sighting_x, sighting_y)
  end

  def sighting_within_range(sighting_x, sighting_y, range)
    miles_dist = evaluate_distance_miles(sighting_x, sighting_y)
    miles_dist < range
  end

  def sighting_within_hotspot_range(sighting)
    in_range = @hotspots.select do |hotspot|
      sighting_within_range(sighting, hotspot, @range)
    end
    in_range.any?
  end

  def sightings_within_hotspot_range(sightings)
    sightings.select do |sighting|
      sighting_within_hotspot_range(sighting)
    end
  end
end