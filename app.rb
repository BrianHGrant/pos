require('pg')
require('pry')
require('money')
require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("./lib/product")
require("./lib/purchase")
also_reload("lib/**/*.rb")

get('/') do
  erb(:index)
end

get('/products') do
  @products = Product.all()
  erb(:products)
end

post('/product') do
  name = params.fetch("new_product_name")
  price = params.fetch("new_product_price")
  product = Product.create({:name => name, :price => price, :purchase_id => nil, :sold => false})
  redirect('/products')
end

delete('/product/:id') do
  product = Product.find(params.fetch('id'))
  product.delete
  redirect('/products')
end

patch('/product/edit') do
  @product = Product.find(params.fetch("product_update"))
  name = params.fetch('name_update') == '' ? @product.name : params.fetch('name_update')
  price = params.fetch('price_update') == '' ? @product.price : params.fetch('price_update')
  sold = params.fetch("is_sold", false)
  @product.update({:name => name, :price => price, :sold => sold})
  redirect('/products')
end

get('/transaction') do
  @products = Product.all()
  erb(:transaction)
end

post('/transaction') do
  ids = []
  params[:selling].each do |item|
    ids.push(item.to_i())
  end
  @purchase = Purchase.create({:total_cost => nil})
  ids.each do |item|
    Product.find(item).update({:purchase_id => @purchase.id()})
  end
  @products = Product.all()
  @purchase.total
  erb(:cart)
end

patch('/transaction/:id') do
  purchase = Purchase.find(params.fetch('id').to_i)
  products = purchase.products()
  products.each do |product|
    product.update({:sold => true})
  end
  redirect('/')
end

get('/sales') do
  @purchases = Purchase.all()
  erb(:sales)
end

post('/sales') do
  @result = 0
  @start = params.fetch('start')
  @finish = params.fetch('finish')
  sales = Purchase.where(created_at: @start..@finish.next)
  sales.each do |purchase|
    purchase.total()
    @result += purchase.total_cost
  end
  @result
  erb(:sales)
end
