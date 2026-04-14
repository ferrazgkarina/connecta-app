class ChangeInterestsToArrayInProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :interests, :string
    add_column :profiles, :interests, :string, array: true, default: []
  end
end
