class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :username
      t.text :description
      t.string :location
      t.string :interests
      t.string :picture

      t.timestamps
    end
  end
end
