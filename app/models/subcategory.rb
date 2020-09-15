class Subcategory < ApplicationRecord
  include Subcategories::Validations
  include Subcategories::Relations
  include Subcategories::Scopes
  
  def to_s 
    name
  end
end
