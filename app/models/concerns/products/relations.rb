module Products::Relations
  extend ActiveSupport::Concern

  included do
    belongs_to :category
    belongs_to :subcategory

    has_many :shopping_carts, dependent: :destroy
    has_many :users, through: :shopping_carts
  end
end
