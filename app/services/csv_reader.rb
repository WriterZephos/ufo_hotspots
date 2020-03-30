require 'csv'

class CsvReader
  def read_from_path(path)
    @lines = CSV.parse(File.read(path), headers: true)
  end

  def lines
    @lines
  end

end