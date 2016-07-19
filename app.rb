require('pg')
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
