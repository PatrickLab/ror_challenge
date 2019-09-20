# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  validates_inclusion_of :score, :in => 1..5

  def to_h
    {
        "id": self.id,
        "user": User.find(self.user_id).name,
        "kombucha": Kombucha.find(self.kombucha_id).name,
        "score": self.score
    }
  end

end
