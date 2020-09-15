require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe ShoppingCart, type: :model do
  
  before (:all) do
    create_default_data
  end

  context 'validation test' do

    before (:each) do
      ShoppingCart.all.each do |s| s.destroy end
    end

    it 'ensure quantity presence and >= 0' do
      shopping_cart = ShoppingCart.new(quantity: -1, user: User.first,
        product: Product.first).save
      expect(shopping_cart).to eq(false)
    end    

    it 'ensure product uniqueness for same user' do
      shopping_cart = ShoppingCart.new(quantity: 2, user: User.first,
        product: Product.first).save

      expect(shopping_cart).to eq(false)
    end
  end

  context 'relations test' do
  
    it 'ensure destroy after product destroy' do
      Product.first.destroy

      expect(ShoppingCart.find_by(user_id: User.first.id)).to eq(nil)
    end

    it 'ensure destroy after user destroy' do
      User.first.destroy

      expect(ShoppingCart.find_by(product_id: Product.first.id)).to eq(nil)
    end

  end

end