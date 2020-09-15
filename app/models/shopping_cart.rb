class ShoppingCart < ApplicationRecord
  include ShoppingCarts::Validations
  include ShoppingCarts::Relations
  include ShoppingCarts::Scopes
end
