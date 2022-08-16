class CreateModes < ActiveRecord::Migration[7.0]
  def change
    create_table :modes do |t|
      t.references :air_conditioner, null: false, foreign_key: true

      t.string :mode, null: false
      t.integer :temperature
      t.integer :max_temperature
      t.integer :min_temperature

      t.timestamps
    end
  end
end
