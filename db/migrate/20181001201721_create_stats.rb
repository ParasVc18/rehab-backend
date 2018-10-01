class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :dose_size
      t.references :user, foreign_key: true
      t.references :poison, foreign_key: true

      t.timestamps
    end
  end
end
