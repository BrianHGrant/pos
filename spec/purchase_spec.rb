require('helper_spec')

describe('Purchase') do
  describe('#products') do
    it "will return the products associated with the purchase" do
      test_purchase = Purchase.create({:total_cost => 95.37, :date => '12/12/12'})
      test_product = Product.create({:name => 'China Doll', :price => 19.45, :sold => true, :purchase_id => test_purchase.id()})
      test_product2 = Product.create({:name => 'Phonograph', :price => 47.34, :sold => true, :purchase_id => test_purchase.id()})
      expect(test_purchase.products()).to(eq([test_product, test_product2]))
    end
  end

  describe('#total') do
    it "will return the total cost of a purchase" do
      test_purchase = Purchase.create({:total_cost => nil, :date => '12/12/12'})
      test_product = Product.create({:name => 'China Doll', :price => 19.45, :sold => true, :purchase_id => test_purchase.id()})
      test_product2 = Product.create({:name => 'Phonograph', :price => 47.34, :sold => true, :purchase_id => test_purchase.id()})
      test_purchase.total()
      expect(test_purchase.total_cost()).to(eq(66.79))
    end
  end
end
