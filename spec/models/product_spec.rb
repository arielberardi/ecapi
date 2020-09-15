require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Product, type: :model do
  
  before (:all) do
    create_default_data
  end

  context 'validation test' do

    it 'ensure name presence' do
      product = Product.new(name: '', category: Category.first, subcategory: Subcategory.first,
        price: 10.0, discount: 0.0, stock: 10.0).save

      expect(product).to eq(false)
    end    

    it 'ensure price presence and >= 0.0' do
      product = Product.new(name: 'FakeProduct1', category: Category.first, subcategory: Subcategory.first,
        price: -1.0, discount: 0.0, stock: 10.0).save

      expect(product).to eq(false)
    end

    it 'ensure stock presence and >= 0.0' do
      product = Product.new(name: 'FakeProduct1', category: Category.first, subcategory: Subcategory.first,
        price: 10.0, discount: 0.0, stock: -10.0).save

      expect(product).to eq(false)
    end

    it 'ensure discount presence and >= 0.0' do
      product = Product.new(name: 'FakeProduct1', category: Category.first, subcategory: Subcategory.first,
        price: 10.0, discount: -20.0, stock: 10.0).save

      expect(product).to eq(false)
    end

    it 'ensure category' do
      product = Product.new(name: 'FakeProduct1', category: nil, subcategory: Subcategory.first,
        price: 10.0, discount: 20.0, stock: 10.0).save

      expect(product).to eq(false)
    end

    it 'ensure subcategory' do
      product = Product.new(name: 'FakeProduct1', category: Category.first, subcategory: nil,
        price: 10.0, discount: -20.0, stock: 10.0).save

      expect(product).to eq(false)
    end

    it 'ensure name uniqueness' do
      product = Product.new(name: Product.first.name, 
        category: Category.first, subcategory: Subcategory.first,
        price: 10.0, discount: 20.0, stock: 10.0).save

      expect(product).to eq(false)
    end
  end

  context 'relations test' do

  end

end