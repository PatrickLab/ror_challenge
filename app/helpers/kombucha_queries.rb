module KombuchaQueries
  extend ActiveSupport::Concern
  module ClassMethods

    def caffeinated
      joins(:ingredients).where(ingredients: {caffeine_free: false}).distinct
    end

    def caffeine_free
      where.not(:id => caffeinated)
    end

    def non_vegan
      joins(:ingredients).where(ingredients: {vegan: false}).distinct
    end

    def vegan
      where.not(:id => non_vegan)
    end

  end
end
