class Ingredient < ApplicationRecord
	belongs_to :recipe

  validates :name, presence: true, length: { maximum: 100 }
end
