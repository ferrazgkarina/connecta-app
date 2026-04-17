class AddUniqueIndexToProfilesUsername < ActiveRecord::Migration[7.1]
  def change
    add_index :profiles, :username, unique: true, if_not_exists: true
  end
end
