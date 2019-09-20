# frozen_string_literal: true

require 'rails_helper'

describe KombuchaQueries do

  ###
  # @low_kombucha = Kombucha.new(:id => 1, :name => "Low", :fizziness_level => "low")
  # @medium_kombucha = Kombucha.new(:id => 2, :name => "Medium", :fizziness_level => "medium")
  # @high_kombucha = Kombucha.new(:id => 3, :name => "High", :fizziness_level => "high")

  # @neutral_ingredient = Ingredient.new(:id => 1, :name => "neutral", :base => false, :caffeine_free => false, :vegan => false)
  # @caffeine_ingredient = Ingredient.new(:id => 2, :name => "caffeine", :base => false, :caffeine_free => true, :vegan => false)
  # @vegan_ingredient = Ingredient.new(:id => 3, :name => "vegan", :base => false, :caffeine_free => false, :vegan => true)
  ###
  describe "Checks kombucha for caffeine_free" do
    it "On single kombucha, returns true if no ingredients have caffeine, false otherwise" do
      expect(Kombucha.all.caffeine_free).not_to eq(Kombucha.all.caffeinated)
    end
  end

  describe "Checks kombucha for vegan" do
    it "On single kombucha, returns true if no ingredients have caffeine, false otherwise" do
      expect(Kombucha.all.vegan).not_to eq(Kombucha.all.non_vegan)
    end
  end
end

