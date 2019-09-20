# frozen_string_literal: true

class Api::KombuchasController < ApiController
  before_action :authenticate_user!
  before_action :set_kombucha, only: [:show, :update]

  # GET /kombuchas
  def index
    @kombuchas = KombuchaRepository.filter(kombucha_params)
    render json: @kombuchas.map(&:to_h), status: :ok
  end

  # GET /kombuchas/:id
  def show
    render json: @kombucha.to_h
  end

  # POST /kombuchas
  # Requires :name, type: string, desc: 'The Kombucha's name
  # Requires :fizziness_level, type: string, desc: 'low medium high'
  def create
    @kombucha = KombuchaRepository.create(kombucha_params)

    if @kombucha.save
      render json: @kombucha.to_h
    else
      render json: { errors: @kombucha.errors }, status: :unprocessable_entity
    end
  end

  # PATCH /kombuchas/:id
  # Optional :name, type: string, desc: 'The Kombucha's name
  # Optional :fizziness_level, type: string, desc: 'low medium high'
  def update
    if @kombucha.update(kombucha_params.except(:id))
      render json: @kombucha.to_h
    else
      render json: { errors: @kombucha.errors }, status: :unprocessable_entity
    end
  end

  # GET /kombuchas/flight
  def flight
    flight = FlightHelper.select_kombuchas(:id => params[:id], :score => params[:score])
    if flight.count < 4
      render json: {:error => "Unable to create flight of 4"}
    else
      render json: flight.map(&:to_h)
    end
  end

  private
    def set_kombucha
      @kombucha = KombuchaRepository.where(params[:id]).first
    end

    def kombucha_params
      params.permit(:id, :name, :fizziness_level, :score, :caffeine_free, :vegan)
    end
end
