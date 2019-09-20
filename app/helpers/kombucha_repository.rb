class KombuchaRepository
  class << self

    def all
      Kombucha.all
    end

    def where(*attrs)
      Kombucha.where(*attrs)
    end

    def create(params)
      Kombucha.new(params)
    end

    def destroy(kombucha)
      kombucha.destroy
    end

    def filter(params)
      kombuchas = Kombucha.all

      if params[:fizziness_level]
        kombuchas = kombuchas.where(:fizziness_level => params[:fizziness_level])
      end

      if params[:caffeine_free]
        if params[:caffeine_free] == "true"
          kombuchas = kombuchas.caffeine_free
        else
          kombuchas = kombuchas.caffeinated
        end
      end

      if params[:vegan]
        if params[:vegan] == "true"
          kombuchas = kombuchas.vegan
        else
          kombuchas = kombuchas.non_vegan
        end
      end

      kombuchas
    end

  end
end
