class CreateWalks < ActiveRecord::Migration[6.1]
  def change
    create_table :walks do |t|
      t.string :start_address
      t.string :end_address
      t.float :start_lat
      t.float :start_lng
      t.float :end_lat
      t.float :end_lng
      t.float :distance

      t.timestamps
    end
  end
end
