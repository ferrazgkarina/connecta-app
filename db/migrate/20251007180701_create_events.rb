class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :category
      t.date :date
      t.time :time
      t.integer :duration
      t.string :address
      t.integer :costs
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
