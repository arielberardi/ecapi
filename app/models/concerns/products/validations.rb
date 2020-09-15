module Products::Validations
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, length: { maximum: 255 }
    validates :name, uniqueness: { case_sensitive: false }
    validates :price, :stock, :discount, presence: true
    validates :price, :stock, :discount, numericality: { greater_than_or_equal_to: 0.0 }
  end
end
