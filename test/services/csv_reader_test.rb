require 'test_helper'
require 'csv_reader'

class CsvReaderTest < ActiveSupport::TestCase
  def test_csv_reader_exists
    # should not throw an error
    CsvReader.new
  end

  def test_read_file
    reader = CsvReader.new

    reader.read_from_path(Rails.root + "test/fixtures/files/test_ufo_sightings.csv")

    assert_equal 6, reader.lines.count
    assert_equal "This is a test", reader.lines[0]["comments"]
    assert_equal "san marcos tx (29.8830556:-97.9411111)", reader.lines[0]["Site Location Lat/Lng"]
  end

  def test_parse_lines
    reader = CsvReader.new

    reader.read_from_path(Rails.root + "test/fixtures/files/test_ufo_sightings.csv")
    sightings = reader.parse_lines

    assert_equal 6, sightings.count
    assert_equal DateTime.new(1949, 10, 10, 20, 30), sightings[0].sighting_date
    assert_equal "cylinder", sightings[0].shape
    assert_equal 45, sightings[0].duration
    assert_equal "This is a test", sightings[0].comments
    assert_equal 29.8830556, sightings[0].latitude
    assert_equal -97.9411111, sightings[0].longitude
  end
end
