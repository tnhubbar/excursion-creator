class CreateExcursions < ActiveRecord::Migration
  def change
    create_table :excursions do |t|
      t.string :name
      t.string :description
      t.integer :days_duration
      t.integer :user_id
    end
  end
end
