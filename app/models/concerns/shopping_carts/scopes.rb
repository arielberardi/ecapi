module ShoppingCarts::Scopes
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order 'shopping_carts.id ASC' }
  end
end
