class AddMessagesLastSeenAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :messages_last_seen_at, :datetime
  end
end
