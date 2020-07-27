class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :venue_id
      t.datetime :date_time
      t.string :type
      t.string :genre
      t.float :price
    end
  end
end
