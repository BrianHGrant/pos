class FixTimestamp < ActiveRecord::Migration
  def change
    remove_column(:purchases, :timestamps)
    add_column(:purchases, :created_at, :datetime)
  end
end
