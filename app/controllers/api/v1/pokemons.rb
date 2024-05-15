# frozen_string_literal: true

module Api
  module V1
    class Pokemons < Grape::API
  
      resource :pokemons do
        desc 'Return all Pokes'
        get '/' do
          pokes = Pokemon.paginate(page: params[:page], per_page: 25)
          
          res = ::PokemonIndexService.new(pokes, request).res
          res
        end
      
        route_param :id do
          get do
            { api: 'Uno solo' }
          end
        end

      end
      
    
    end
  end
end