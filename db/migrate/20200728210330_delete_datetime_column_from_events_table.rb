class DeleteDatetimeColumnFromEventsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :date_time
  end
end
