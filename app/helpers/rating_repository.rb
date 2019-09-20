class RatingRepository
  class << self

    def all
      Rating.all
    end

    def where(*attrs)
      Rating.where(*attrs)
    end

    def create(current_user, kombucha, score)
      rating = Rating.where(:user_id => current_user, :kombucha_id => kombucha).first
      if rating.nil?
        rating = Rating.new(:user_id => current_user, :kombucha_id => kombucha, :score => score)
      end
      rating
    end

    def destroy(rating)
      rating.destroy
    end

  end
end
