module Subcategories::Scopes
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order 'subcategories.name ASC' }
  end
end
