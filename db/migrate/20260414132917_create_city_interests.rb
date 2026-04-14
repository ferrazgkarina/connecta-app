class CreateCityInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :city_interests do |t|
      t.string :email, null: false
      t.string :city, null: false
      t.timestamps
    end
  end
end
