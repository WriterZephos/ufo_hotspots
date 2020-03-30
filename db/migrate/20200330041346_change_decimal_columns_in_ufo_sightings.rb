class ChangeDecimalColumnsInUfoSightings < ActiveRecord::Migration[6.0]
  def change
    change_column :ufo_sightings, :latitude, :decimal, :precision => 10, :scale => 7
    change_column :ufo_sightings, :longitude, :decimal, :precision => 10, :scale => 7
  end
end
