class Product < ActiveRecord::Base
  belongs_to(:purchase)
  validates(:name, :presence => true)
  validates(:price, :presence => true)
  before_save(:convert_price)

  scope(:not_sold, -> do
    where({:sold => false})
  end)

private

  define_method(:convert_price) do
    Money.us_dollar(self.price()*100).format
  end
end
