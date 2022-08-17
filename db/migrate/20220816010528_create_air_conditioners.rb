class CreateAirConditioners < ActiveRecord::Migration[7.0]
  def change
    create_table :air_conditioners do |t|
      t.references :user, null: false, foreign_key: true

      t.boolean :owner_only, null: false, default: false
      t.string :name, null: false
      t.boolean :on, null: false
      t.string :fan_speed, null: false
      t.string :mode, null: false
      t.integer :temperature

      t.timestamps
    end
  end
end
