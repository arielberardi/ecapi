require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Subcategory, type: :model do
  
  before (:all) do
    create_default_data
  end

  context 'validation test' do

    it 'ensure name presence' do
      subcategory = Subcategory.new(name: '', category: Category.first).save
      expect(subcategory).to eq(false)
    end    

    it 'ensure category presence' do
      subcategory = Subcategory.new(name: 'TestCategory', category: nil).save
      expect(subcategory).to eq(false)
    end

    it 'ensure name uniqueness in a category' do
      subcategory = Subcategory.new(name: Subcategory.first.name, category: Category.first).save
      expect(subcategory).to eq(false)
    end
  end

  context 'relations test' do
  
    it 'belongs to one category' do
      last_value = Category.first.subcategories.count 
      subcategory = Subcategory.new(name: 'TestCategory1', category: Category.first).save
      new_value = Category.first.subcategories.count 

      expect((new_value-last_value)).to eq(1)
    end
  end
end