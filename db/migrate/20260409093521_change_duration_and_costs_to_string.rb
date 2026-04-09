class ChangeDurationAndCostsToString < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :duration, :string
    change_column :events, :costs, :string
  end
end
