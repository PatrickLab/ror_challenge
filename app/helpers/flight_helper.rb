module FlightHelper

    def self.select_kombuchas(*args)
      filters = args.first
      kombucha_ids =  Kombucha.all.pluck(:id)
      minimum_rating = 0
      selected = []
      bases = []

      unless filters[:id].nil?
        kombucha = KombuchaRepository.where(:id => filters[:id]).first
        kombucha.ingredients.select{|ing|
          if ing.base
            bases << ing.id
            selected << kombucha
            break
          end
        }
      end

      unless filters[:score].nil?
        minimum_rating = filters[:score].to_i
      end

      until selected.count >= 4
        return selected if kombucha_ids.empty?

        selected_id = kombucha_ids.sample
        kombucha_ids.delete selected_id

        kombucha = KombuchaRepository.where(:id => selected_id).first

        next if kombucha.nil?
        next unless RatingQueries.average(kombucha.id) >= minimum_rating

        kombucha.ingredients.select{|ing|
          if ing.base && bases.exclude?(ing.id)
            bases << ing.id
            selected << kombucha
            break
          end
        }

      end
      selected
    end

end
