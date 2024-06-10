# frozen_string_literal: true

module Api
  module V1
    class PokemonsList < Grape::API
      namespace :pokemons do
        desc 'Return all Pokes'
        params do
          optional :page, type: Integer, default: 1
        end
        get '/' do
          ::PokemonCrudService.new(request, declared(params)).index
        end

        namespace :search do
          desc 'Search pokemon by name'
          params do
            requires :name, type: String, desc: 'Name of the Pokémon'
          end
          get do
            ::PokemonSearchService.search(declared(params))
          end
        end

        route_param :id do
          desc 'Return information about a specific Pokémon'
          params do
            requires :id, types: [Integer, String], desc: 'id of Pokemon or name.'
          end
          get do
            poke = ::PokemonCrudService.new(nil, declared(params)).show

            poke.nil? ? error!("Pokemon #{params[:id]}: not found", 404) : poke
          end
        end
      end
    end
  end
end
