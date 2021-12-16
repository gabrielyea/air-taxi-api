class AddReservedateToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :reserve_date, :date
  end
end
