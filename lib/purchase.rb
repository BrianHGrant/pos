class Purchase < ActiveRecord::Base
  has_many(:products)

  def total
    result = 0
    products = self.products()
    products.each do |product|
      result += product.price()
    end
    self.total_cost = result
  end
end
