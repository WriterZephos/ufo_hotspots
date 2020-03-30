require 'test_helper'
require 'hotspot_locator'

class HotspotLocatorTest < ActiveSupport::TestCase
  def test_hotspot_locator_exists
    # should not throw an error
    HotspotLocator.new
  end

  def test_hotspot_evaluate_distance
    sighting_x = {longitude: 2, latitude: 2}
    sighting_y = {longitude: -2, latitude: -2}

    hotspot_loc = HotspotLocator.new
    result = hotspot_loc.evaluate_distance(sighting_x, sighting_y)
    
    assert_equal 5.6569, result.round(4)
  end

  def test_hotspot_evaluate_distance_miles
    sighting_x = {longitude: 2, latitude: 2}
    sighting_y = {longitude: -2, latitude: -2}
    expected_miles = (5.6569 * 69).round(1)

    hotspot_loc = HotspotLocator.new
    miles_dist = hotspot_loc.evaluate_distance_miles(sighting_x, sighting_y)

    assert_equal expected_miles, miles_dist.round(1)
  end

  def test_sighting_within_range
    sighting_inside_range = {longitude: 2, latitude: 2}
    sighting_outside_range = {longitude: 100, latitude: -100}
    from_sighting = {longitude: -2,latitude: -2}

    hotspot_loc = HotspotLocator.new

    assert hotspot_loc.sighting_within_range(sighting_inside_range, from_sighting, 750)
    refute hotspot_loc.sighting_within_range(sighting_outside_range, from_sighting, 750)
  end

  def test_sighting_within_hotspot_range
    sighting_inside_range = {longitude: 2, latitude: 2}
    sighting_outside_range = {longitude: 100, latitude: -100}
    hotspot_sighting = {longitude: -2,latitude: -2}

    hotspot_loc = HotspotLocator.new([hotspot_sighting], 750)
    
    assert hotspot_loc.sighting_within_hotspot_range(sighting_inside_range)
    refute hotspot_loc.sighting_within_hotspot_range(sighting_outside_range)
  end

  def test_sightings_within_hotspot_range
    sightings_to_test = [{longitude: 2, latitude: 2},{longitude: 1, latitude: -1},{longitude: 100, latitude: -100},{longitude: 500, latitude: -500}]
    hotspot_sighting = {longitude: -2,latitude: -2}

    hotspot_loc = HotspotLocator.new([hotspot_sighting], 750)
    
    assert_equal 2, hotspot_loc.sightings_within_hotspot_range(sightings_to_test).count
  end

  def test_sightings_within_hotspot_range_use_model
    sightings_to_test = [
      UfoSighting.new({longitude: 2, latitude: 2}),
      UfoSighting.new({longitude: 1, latitude: -1}),
      UfoSighting.new({longitude: 100, latitude: -100}),
      UfoSighting.new({longitude: 500, latitude: -500})]
    hotspot_sighting = UfoSighting.new({longitude: -2,latitude: -2})

    hotspot_loc = HotspotLocator.new([hotspot_sighting], 750)
    
    assert_equal 2, hotspot_loc.sightings_within_hotspot_range(sightings_to_test).count
  end
end
