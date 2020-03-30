require 'csv'

class CsvReader
  def read_from_path(path)
    @lines = CSV.parse(File.read(path), headers: true)
  end

  def lines
    @lines
  end

  # TODO: add error handling to make this fail gracefully when a line 
  # is malformed or a value is invalid
  # Parses the lines from the csv file loaded via read_from_path and returns
  # an array of UfoSightings.
  def parse_lines
    @lines.map do |line|
      begin
        # Extract values in need of further processing
        lat_long_match_data = line.fetch("Site Location Lat/Lng").scan(/(-?\d+(\.\d+)?)/)
        city_state_match_data = line.fetch("Site Location Lat/Lng").scan(/(^[a-zA-Z\.\s]*\s{1})([a-zA-z)(\/]*)\s{1,}\((-?\d+(\.\d+)?):(-?\d+(\.\d+)?)\)$/)

        # Posix standard is used, meaning 2 digit years between 00 and 69 will be
        # in century 2000, but these are historical sightings so that can't happen.
        sighting_date_string = line.fetch("Sighting date/time")
        sighting_date = DateTime.strptime(sighting_date_string, "%d/%m/%y %H:%M")
        sighting_date = sighting_date.prev_year(100) if sighting_date > Date.today

        # Assemble params
        sighting_params = {
          sighting_date: sighting_date,
          shape: line.fetch("shape"),
          duration: (line.fetch("duration (seconds)").to_i / 60).round(0),
          comments: line.fetch("comments"),
          city: city_state_match_data[0][0],
          state: city_state_match_data[0][1],
          latitude: lat_long_match_data[0][0],
          longitude: lat_long_match_data[1][0]
        }

        # Instantiate object
        UfoSighting.new(sighting_params)
      rescue => e
        next
      end
    end
  end
end