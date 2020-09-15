module Products::Scopes
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order 'products.name ASC' }
  end
end
