require 'test_helper'
require 'hotspot_locator'

class HotspotLocatorTest < ActiveSupport::TestCase
  def test_hotspot_locator_exists
    # should not throw an error
    HotspotLocator.new
  end

  def test_hotspot_evaluate_distance
    point_x = {long: 2, lat: 2}
    point_y = {long: -2, lat: -2}

    hotspot_loc = HotspotLocator.new
    result = hotspot_loc.evaluate_distance(point_x, point_y)
    
    assert_equal 5.6569, result.round(4)
  end

  def test_hotspot_evaluate_distance_miles
    point_x = {long: 2, lat: 2}
    point_y = {long: -2, lat: -2}
    expected_miles = (5.6569 * 69).round(1)

    hotspot_loc = HotspotLocator.new
    miles_dist = hotspot_loc.evaluate_distance_miles(point_x, point_y)

    assert_equal expected_miles, miles_dist.round(1)
  end

  def test_point_within_range
    point_inside_range = {long: 2, lat: 2}
    point_outside_range = {long: 100, lat: -100}
    from_point = {long: -2,lat: -2}

    hotspot_loc = HotspotLocator.new

    assert hotspot_loc.points_within_range(point_inside_range, from_point, 750)
    refute hotspot_loc.points_within_range(point_outside_range, from_point, 750)
  end

end
