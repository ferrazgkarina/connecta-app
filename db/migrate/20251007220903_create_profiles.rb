class CreateProfiles < ActiveRecord::Migration[7.1]
  def up
    return if table_exists?(:profiles)

    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :username
      t.text :description
      t.string :location
      t.string :interests
      t.string :picture
      t.timestamps
    end

    add_index :profiles, :username, unique: true unless index_exists?(:profiles, :username, unique: true)
  end

  def down
    drop_table :profiles if table_exists?(:profiles)
  end
end
