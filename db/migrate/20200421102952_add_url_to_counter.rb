class AddUrlToCounter < ActiveRecord::Migration[6.0]
  def change
    add_column :counters, :url, :string
  end
end
