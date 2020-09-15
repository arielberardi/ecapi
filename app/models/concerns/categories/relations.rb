module Categories::Relations
  extend ActiveSupport::Concern

  included do
    has_many :subcategories, dependent: :destroy
    has_many :products
  end
end
