class CreateJoinTableUserPlane < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :planes do |t|
      t.index [:user_id, :plane_id]
    end
  end
end
