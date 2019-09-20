module RatingQueries

  def self.average(kombucha_id)
    average = 0
    kombucha = KombuchaRepository.where(:id => kombucha_id).first
    kombucha.ratings.each do |rating|
      average += rating.score
    end
    average = average / kombucha.ratings.count unless kombucha.ratings.count == 0
    average
  end

end