class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :location, :string
    add_column :users, :interests, :text
    add_column :users, :description, :text
    add_column :users, :picture, :string
  end
end
