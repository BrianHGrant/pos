class Product < ActiveRecord::Base
  belongs_to(:purchase)

  scope(:not_sold, -> do
    where({:sold => false})
  end)
end
