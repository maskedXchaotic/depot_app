class CreateCounter < ActiveRecord::Migration[6.0]
  def change
    create_table :counters do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :count
    end
  end
end
