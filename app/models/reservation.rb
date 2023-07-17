class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :videogame

  validates :days, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
end
