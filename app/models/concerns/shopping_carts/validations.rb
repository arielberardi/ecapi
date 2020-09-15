module ShoppingCarts::Validations
  extend ActiveSupport::Concern

  included do
    validates :quantity, presence: true
    validates :quantity, numericality: { greater_than_or_equal_to: 0.0 }
    validates :product, uniqueness: { scope: [:user_id] }
  end
end
