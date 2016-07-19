require('helper_spec')

describe('Product') do
  describe('#purchase') do
    it('will return the associated purchase for a product') do
      test_purchase = Purchase.create({:total_cost => 95.37, :date => '12/12/12'})
      test_product = Product.create({:name => 'China Doll', :price => 19.45, :sold => true, :purchase_id => test_purchase.id()})
      expect(test_product.purchase()).to(eq(test_purchase))
    end
  end

  describe('.not_sold') do
    it('returns the unsold items') do
      test_product = Product.create({:name => 'China Doll', :price => 19.45, :sold => false, :purchase_id => nil})
      test_product2 = Product.create({:name => 'Tiffany Lamp', :price => 8000, :sold => true, :purchase_id => nil})
      expect(Product.not_sold()).to(eq([test_product]))
    end
  end

  it "ensures the name key has a value" do
    test_product = Product.new({:name => '', :price => 19.45, :sold => false, :purchase_id => nil})
    expect(test_product.save()).to(eq(false))
  end

  it "ensures the price key has a value" do
    test_product = Product.new({:name => 'Tiffany Lamp', :price => "", :sold => false, :purchase_id => nil})
    expect(test_product.save()).to(eq(false))
  end

  it "formats price to dollars and cents" do
    test_product = Product.create({:name => 'Tiffany Lamp', :price => "45.5", :sold => false, :purchase_id => nil})
    expect(test_product.price()).to(eq(45.50))
  end
end
