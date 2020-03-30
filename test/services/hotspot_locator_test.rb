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
end
