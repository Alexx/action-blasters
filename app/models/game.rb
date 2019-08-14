class Game < ApplicationRecord
  belongs_to :user
  has_many :players, dependent: :destroy
  has_many :locations, dependent: :destroy

  def start
    return '/games'
  end
end
