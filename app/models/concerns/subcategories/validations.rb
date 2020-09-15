module Subcategories::Validations
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, length: { maximum: 255 }
    validates :name, uniqueness: { case_sensitive: false, scope: [:category_id] }
  end
end
