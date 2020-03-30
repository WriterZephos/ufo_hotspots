class HotspotLocator
  def evaluate_distance(point_x, point_y)
    long_dist = point_x[:long] - point_y[:long]
    lat_dist = point_x[:lat] - point_y[:lat]
    Math.sqrt (long_dist * long_dist) + (lat_dist * lat_dist)
  end

  def evaluate_distance_miles(point_x, point_y)
    69 * evaluate_distance(point_x, point_y)
  end
end