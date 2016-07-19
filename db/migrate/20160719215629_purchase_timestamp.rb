class PurchaseTimestamp < ActiveRecord::Migration
  def change
    add_column(:purchases, :timestamps, :datetime)
    remove_column(:purchases, :date)
  end
end
