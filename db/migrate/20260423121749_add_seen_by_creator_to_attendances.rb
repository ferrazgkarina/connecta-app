class AddSeenByCreatorToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_column :attendances, :seen_by_creator, :boolean, default: false, null: false
  end
end
