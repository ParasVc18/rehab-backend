class CreatePoisons < ActiveRecord::Migration[5.2]
  def change
    create_table :poisons do |t|
      t.string :name
      t.integer :dose_size
      t.string :dose_type
      t.integer :no_of_doses
      t.integer :price_of_doses
      t.string :currency
      t.integer :time_period
      t.string :time_type
      t.integer :avg_value
      t.integer :alpha
      t.integer :progress
      t.integer :counter
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
