class CreateVideogames < ActiveRecord::Migration[7.0]
  def change
    create_table :videogames do |t|
      t.string :name
      t.string :photo
      t.text :description
      t.decimal :price_per_day

      t.timestamps
    end
  end
end
