class DeletePriceFromEventsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :price
  end
end
