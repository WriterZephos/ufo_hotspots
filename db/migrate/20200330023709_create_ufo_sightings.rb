class CreateUfoSightings < ActiveRecord::Migration[6.0]
  def change
    create_table :ufo_sightings do |t|
      t.datetime :sighting_date
      t.string :shape
      t.integer :duration
      t.text :comments
      t.text :city
      t.text :state
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
