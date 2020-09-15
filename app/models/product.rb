class Product < ApplicationRecord
  include Products::Validations
  include Products::Relations
  include Products::Scopes

  def to_s
    name
  end
end
