class IntToFloatInPoisons < ActiveRecord::Migration[5.2]
  def change
    change_column :poisons, :progress, :float
    change_column :poisons, :avg_value, :float
    change_column :poisons, :alpha, :float
  end
end
