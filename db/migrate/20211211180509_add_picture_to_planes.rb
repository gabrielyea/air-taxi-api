class AddPictureToPlanes < ActiveRecord::Migration[6.1]
  def change
    add_column :planes, :picture, :string
  end
end
