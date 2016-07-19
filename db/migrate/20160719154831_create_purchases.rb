class CreatePurchases < ActiveRecord::Migration
  def change
    create_table(:purchases) do |t|
      t.column(:total_cost, :float)
      t.column(:date, :date)
    end

    add_column(:products, :purchase_id, :integer)
  end
end
