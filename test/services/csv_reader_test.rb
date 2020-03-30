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

end