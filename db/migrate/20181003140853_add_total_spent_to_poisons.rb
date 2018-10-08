class AddTotalSpentToPoisons < ActiveRecord::Migration[5.2]
  def change
    add_column :poisons, :total, :integer
    add_column :poisons, :spent, :integer
  end
end
