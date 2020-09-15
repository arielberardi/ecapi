module Subcategories::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :category
    has_many :products
  end
end
