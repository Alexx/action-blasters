class Location < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :enemies, dependent: :destroy
  belongs_to :game
  validates :name, presence: true

end
