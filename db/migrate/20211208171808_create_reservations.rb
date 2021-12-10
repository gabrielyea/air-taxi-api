class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :reservation_date
      t.references :user, null: false, foreign_key: true
      t.references :plane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
