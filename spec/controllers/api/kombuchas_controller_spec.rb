# frozen_string_literal: true

require 'rails_helper'

describe Api::KombuchasController, type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:kombucha) { Kombucha.first }
  let(:current_user) { User.first }
  let(:headers) { { 'USER-ID': current_user.id } }

  describe "#index" do
    it "renders a collection of kombuchas" do
      get '/api/kombuchas', params: {}, headers: headers

      expect(response.status).to eq(200)
      expect(response_body.length).to eq(Kombucha.count)
    end
  end

  describe "#show" do
    it "shows a kombucha" do
      get "/api/kombuchas/#{kombucha.id}", params: {}, headers: headers

      expect(response.message).to eq("OK")
      expect(response_body["id"]).to eq(kombucha.id)
    end
  end

  describe "#create" do
    let(:request_params) {
      {
          name: "Orange Pop",
          fizziness_level: "low"
      }
    }

    it "creates a kombucha" do
      expect { post "/api/kombuchas", params: request_params, headers: headers }.to change(Kombucha, :count).by(1)
    end

    it "does not create kombucha if fizziness level is invalid" do
      request_params[:fizziness_level] = "fake"

      expect { post "/api/kombuchas", params: request_params, headers: headers }.not_to change(Kombucha, :count)
    end
  end

  describe "#update" do
    let(:request_params) {
      {
          name: "new name",
          fizziness_level: "low"
      }
    }

    it "updates kombucha fizziness level and name" do
      patch "/api/kombuchas/#{kombucha.id}", params: request_params, headers: headers

      expect(response.message).to eq("OK")
      expect(response_body["name"]).to eq("new name")
    end

    it "does not update kombucha if fizziness level is invalid" do
      request_params[:fizziness_level] = "fake"

      patch "/api/kombuchas/#{kombucha.id}", params: request_params, headers: headers

      expect(response.message).to eq("Unprocessable Entity")
    end

    describe "#flight" do
      let(:request_params_0_score) {
        {
            score: 0
        }
      }

      let(:request_params_6_score) {
        {
            score: 6
        }
      }

      it "creates a flight of 4 kombuchas selected randomly, if possible" do
        get "/api/kombuchas/flight", params: request_params_0_score, headers: headers

        expect(response.message).to eq("OK")
        expect(response_body.count).to eq(4)
      end

      it "creates a flight of 4 kombuchas selected randomly, if possible" do
        get "/api/kombuchas/flight", params: request_params_6_score, headers: headers

        expect(response.message).to eq("OK")
        expect(response_body["error"]).to eq("Unable to create flight of 4")
      end

    end

  end
end
