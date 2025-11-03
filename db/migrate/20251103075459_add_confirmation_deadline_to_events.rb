class AddConfirmationDeadlineToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :confirmation_deadline, :string
  end
end
