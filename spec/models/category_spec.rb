require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Category, type: :model do
  
  before (:all) do
    create_default_data
  end

  context 'validation test' do

    it 'ensure name presence' do
      category = Category.new(name: '').save
      expect(category).to eq(false)
    end    

    it 'ensure name uniqueness' do
      category = Category.new(name: Category.first.name).save
      expect(category).to eq(false)
    end
  end

  context 'relations test' do
  
    it 'can have many subcategories' do
      category = Category.first
      Subcategory.new(name: 'Ilumination', category: category).save
      Subcategory.new(name: 'Tools', category: category).save

      expect(category.subcategories.count).to eq(3)
    end

    it 'destroy subcategories after destroy category' do
      category = Category.create(name: 'TestCategory')

      Subcategory.new(name: 'TestSub1', category: category).save

      category.destroy

      expect(Subcategory.find_by(name: 'TestSub1')).to eq(nil)
    end
  end

end