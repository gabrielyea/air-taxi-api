class CreatePlanes < ActiveRecord::Migration[6.1]
  def change
    create_table :planes do |t|
      t.string :model
      t.string :registration
      t.text :description
      t.decimal :cruise_speed
      t.decimal :tour_price

      t.timestamps
    end
  end
end
