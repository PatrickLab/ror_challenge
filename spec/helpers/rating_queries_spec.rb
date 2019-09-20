# frozen_string_literal: true

require 'rails_helper'

describe RatingQueries do

  ###
  # @low_kombucha = Kombucha.new(:id => 1, :name => "Low", :fizziness_level => "low")
  # @medium_kombucha = Kombucha.new(:id => 2, :name => "Medium", :fizziness_level => "medium")
  # @high_kombucha = Kombucha.new(:id => 3, :name => "High", :fizziness_level => "high")

  # @neutral_ingredient = Ingredient.new(:id => 1, :name => "neutral", :base => false, :caffeine_free => false, :vegan => false)
  # @caffeine_ingredient = Ingredient.new(:id => 2, :name => "caffeine", :base => false, :caffeine_free => true, :vegan => false)
  # @vegan_ingredient = Ingredient.new(:id => 3, :name => "vegan", :base => false, :caffeine_free => false, :vegan => true)
  ###
  describe "Find average rating score for given kombucha" do
    kombucha = Kombucha.first
    user = User.create!(:id => 123, :name => "Patrick", :email => "development.labreche@ackroo.com")
    kombucha.ratings << Rating.create!(:id => 123, :kombucha_id => kombucha.id, :user_id => User.first.id, :score => 1)
    kombucha.ratings << Rating.create!(:id => 234, :kombucha_id => kombucha.id, :user_id => user.id, :score => 1)

    it "On single kombucha, returns average rating score" do
      expect(RatingQueries.average(kombucha.id)).to eq(1)
    end
  end

end

