class Location < ApplicationRecord
  has_many :players
  has_many :enemies
  belongs_to :game
  validates :name, presence: true

end
