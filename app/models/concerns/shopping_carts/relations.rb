module ShoppingCarts::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :product
  end
end
