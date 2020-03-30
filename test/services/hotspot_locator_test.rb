require 'test_helper'
require 'hotspot_locator'

class HotspotLocatorTest < ActiveSupport::TestCase
  def test_hotspot_locator_exists
    # should not throw an error
    HotspotLocator.new
  end
end
