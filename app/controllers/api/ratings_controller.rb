# frozen_string_literal: true

class Api::RatingsController < ApiController
  include RatingQueries
  before_action :authenticate_user!
  before_action :set_rating, only: [:show, :update]

  # GET /ratings
  def index
    # Return a user's ratings
    @ratings = RatingRepository.where(:user_id => current_user.id)

    json = {}
    unless @ratings.nil?
      json = @ratings.map(&:to_h)
    end

    render json: json, status: :ok
  end

  # POST /kombuchas/:id/ratings
  # Requires :score, type: int, desc: 'Rating score from 1 to 5'
  def create
    # Return existing rating if user attempts to create again
    @rating = RatingRepository.create(current_user.id, params[:kombucha_id], params[:score])

    if @rating.save
      render json: { :Rating => @rating.to_h, :Average => RatingQueries.average(params[:kombucha_id])}
    else
      render json: { errors: @rating.errors }, status: :unprocessable_entity
    end
  end

  # PATCH /kombuchas/:id/ratings/:id
  # Requires :score, type: int, desc: 'Rating score from 1 to 5'
  def update
    if @rating.update(rating_params)
      render json: { :Rating => @rating.to_h, :Average => RatingQueries.average(params[:kombucha_id])}
    else
      render json: { errors: @rating.errors }, status: :unprocessable_entity
    end
  end

  private
    def set_rating
      @rating = RatingRepository.where(:id => params[:id]).first
    end

    def rating_params
      params.require(:rating).permit(:kombucha_id, :score)
    end
end
