class Player < ApplicationRecord
  belongs_to :location
  belongs_to :game
end
