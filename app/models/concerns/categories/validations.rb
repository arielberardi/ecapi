module Categories::Validations
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, length: { maximum: 255 }
    validates :name, uniqueness: { case_sensitive: false }
  end
end
