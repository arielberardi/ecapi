module Categories::Scopes
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order 'categories.name ASC' }
  end
end
