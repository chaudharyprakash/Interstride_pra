class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name, limit: 100, null: false
      t.text :instructions, limit: 1000, null: false
      t.integer :cooking_time, null: false

      t.timestamps
    end
  end
end
