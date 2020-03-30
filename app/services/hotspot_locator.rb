class HotspotLocator

  def initialize(hotspots = [], range = 0)
    @hotspots = hotspots
    @range = range
  end

  def evaluate_distance(point_x, point_y)
    long_dist = point_x[:long] - point_y[:long]
    lat_dist = point_x[:lat] - point_y[:lat]
    Math.sqrt (long_dist * long_dist) + (lat_dist * lat_dist)
  end

  def evaluate_distance_miles(point_x, point_y)
    69 * evaluate_distance(point_x, point_y)
  end

  def point_within_range(point_x, point_y, range)
    miles_dist = evaluate_distance_miles(point_x, point_y)
    miles_dist < range
  end

  def point_within_hotspot_range(point)
    in_range = @hotspots.select do |hotspot|
      point_within_range(point, hotspot, @range)
    end
    in_range.any?
  end
end