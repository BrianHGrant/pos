class TotalCostFormat < ActiveRecord::Migration
  def change
    remove_column(:purchases, :total_cost)
    add_column(:purchases, :total_cost, :NUMERIC, scale: 2)
  end
end
