class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :activities
      t.string :description
      t.integer :excursion_id
    end
  end
end
