require 'test_helper'
require 'csv_reader'

class CsvReaderTest < ActiveSupport::TestCase
  def test_csv_reader_exists
    # should not throw an error
    CsvReader.new
  end
end
