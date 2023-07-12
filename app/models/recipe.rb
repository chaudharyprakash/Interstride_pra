class Recipe < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many :ingredients

  validates :name, presence: true, length: { maximum: 100 }
  validates :instructions, presence: true, length: { maximum: 1000 }
  validates :cooking_time, presence: true, numericality: { greater_than: 0 }

  mapping do
    indexes :name, type: 'text'
    indexes :instructions, type: 'text'
    indexes :cooking_time, type: 'integer'
    indexes :ingredients do
      indexes :name, type: 'text'
    end
  end

  def as_indexed_json(_options = {})
    self.as_json(include: { ingredients: { only: :name } })
  end

  def self.search(cuisine, ingredient)
    query = {}
    query[:match] = { name: cuisine } if cuisine.present?
    query[:match] = { 'ingredients.name': ingredient } if ingredient.present?

    __elasticsearch__.search(query)
  end
end
