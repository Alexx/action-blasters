class Game < ApplicationRecord

  belongs_to :user

  def start
    return '/games'
  end
end
