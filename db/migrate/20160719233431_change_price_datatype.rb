class ChangePriceDatatype < ActiveRecord::Migration
  def change
    remove_column(:products, :price)
    add_column(:products, :price, :NUMERIC, scale: 2)
  end
end
