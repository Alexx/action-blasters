class Location < ApplicationRecord
  has_many :players
  has_many :enemies
  validates :name, presence: true
  
end
