class Category < ApplicationRecord
  include Categories::Validations
  include Categories::Relations
  include Categories::Scopes

  def to_s
    name
  end
end
