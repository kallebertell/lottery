class Event < ActiveRecord::Base
  attr_accessible :uid, :name

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user 

  validates :name, length: { minimum: 2, maximum: 35 }

  def winners
    participations.select { |p| p.won } .map { |p| p.user }
  end

  def non_winning_participations 
    participations.select { |p| !p.won }
  end

  def select_winning_candidate 
    non_winning_participations.sample
  end

  def select_winner_and_save
    winning_participation = select_winning_candidate

    if (winning_participation.nil?) then
      nil
    else
      winning_participation.won = true
      winning_participation.save
      winning_participation.user
   end
  end

end
