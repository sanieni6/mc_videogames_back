class Videogame < ApplicationRecord
  has_one :reservation, dependent: :destroy

  validates :name, presence: true
  validates :photo, presence: true
  validates :description, presence: true
  validates :price_per_day, presence: true
end
