class CreateShares < ActiveRecord::Migration[7.1]
  def change
    create_table :shares do |t|
      t.references :sharer, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true
      t.boolean :read, default: false, null: false
      t.timestamps
    end
  end
end
