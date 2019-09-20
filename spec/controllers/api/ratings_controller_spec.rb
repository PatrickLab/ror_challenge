# frozen_string_literal: true

require 'rails_helper'

describe Api::RatingsController, type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:kombucha) { Kombucha.first }
  let(:rating) { Rating.create!(:id => 1, :user_id => current_user.id, :kombucha_id => kombucha.id, :score => 1) }
  let(:current_user) { User.first }
  let(:headers) { { 'USER-ID' => current_user.id } }

  describe "#index" do
    it "renders a collection of ratings based on user" do
      get '/api/ratings', params: {}, headers: headers

      expect(response.status).to eq(200)
      expect(response_body.length).to eq(current_user.ratings.count)
    end
  end

  describe "#create" do
    let(:request_params) {
      {
          score: 5,
          kombucha_id: kombucha.id
      }
    }
    it "creates a rating" do
      expect { post "/api/kombuchas/#{request_params[:kombucha_id]}/ratings", params: request_params, headers: headers }.to change(Rating, :count).by(1)
    end

    it "does not create rating if rating score is invalid" do
      request_params[:score] = "6"

      expect { post "/api/kombuchas/#{request_params[:kombucha_id]}/ratings", params: request_params, headers: headers }.not_to change(Rating, :count)
    end
  end

  describe "#update" do
    let(:request_params) {
      {
          rating: {
              score: 2
          }
      }
    }

    it "updates rating score" do
      patch "/api/kombuchas/#{kombucha.id}/ratings/#{rating.id}", params: request_params, headers: headers

      expect(response.message).to eq("OK")
      expect(response_body["Rating"]["score"]).to eq(2)
    end

    it "does not update rating if score is invalid" do
      request_params[:rating][:score] = 6

      patch "/api/kombuchas/#{kombucha.id}/ratings/#{rating.id}", params: request_params, headers: headers

      expect(response.message).to eq("Unprocessable Entity")
    end
  end
end
