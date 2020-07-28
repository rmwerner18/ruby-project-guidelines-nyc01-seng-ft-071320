class AddCityColumnToEventsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :city, :string
  end
end
