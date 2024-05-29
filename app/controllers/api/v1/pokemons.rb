# frozen_string_literal: true

module Api
  module V1
    class Pokemons < Grape::API
      resource :pokemons do
        # GET /api/v1/pokemons/
        desc 'Return all Pokes'
        params do
          optional :page, type: Integer, default: 1
        end
        get '/' do
          ::PokemonCrudService.new(request, declared(params)).index
        end

        # POST /api/v1/pokemons/
        desc 'Create new Pokemon'
        params do
          requires :pokemon, type: Hash do
            requires :name, type: String, desc: 'Name of new Pokemon'
            requires :type_1, type: String, desc: 'type_1 of new Pokemon'
            optional :type_2, type: String, default: nil, desc: 'type_2 of new Pokemon'
            optional :total, type: Integer, default: 1, desc: 'Total'
            optional :hp, type: Integer, default: 1, desc: 'Hp of POkemon'
            optional :attack, type: Integer, default: 1, desc: 'Attack of POkemon'
            optional :defense, type: Integer, default: 1, desc: 'defense of POkemon'
            optional :sp_atk, type: Integer, default: 1, desc: 'Sp_Atk of POkemon'
            optional :sp_def, type: Integer, default: 1, desc: 'Sp_Def of POkemon'
            optional :speed, type: Integer, default: 1, desc: 'Speed of POkemon'
            optional :generation, type: Integer, default: 1, desc: 'Generation of POkemon'
            optional :legendary, type: Boolean, default: false, desc: 'Is Legendary POkemon'
          end
        end
        post '/' do
          poke = ::PokemonCrudService.new(nil, declared(params)).create

          poke.nil? ? error!("POkemon #{params[:pokemon][:name]} already exist", 409) : poke
        end

        # PUT /api/v1/pokemons/
        route_param :id do
          desc 'Update Pokemon by ID'
          params do
            requires :id, types: Integer, desc: 'ID of Pokemon.'
            requires :pokemon, type: Hash do
              optional :name, type: String, desc: 'Name of new Pokemon'
              optional :type_1, type: String, desc: 'type_1 of new Pokemon'
              optional :type_2, type: String, desc: 'type_2 of new Pokemon'
              optional :total, type: Integer, desc: 'Total'
              optional :hp, type: Integer, desc: 'Hp of POkemon'
              optional :attack, type: Integer, desc: 'Attack of POkemon'
              optional :defense, type: Integer, desc: 'defense of POkemon'
              optional :sp_atk, type: Integer, desc: 'Sp_Atk of POkemon'
              optional :sp_def, type: Integer, desc: 'Sp_Def of POkemon'
              optional :speed, type: Integer, desc: 'Speed of POkemon'
              optional :generation, type: Integer, desc: 'Generation of POkemon'
              optional :legendary, type: Boolean, desc: 'Is Legendary POkemon'
              at_least_one_of :name, :type_1, :total, :hp, :attack, :defense, :sp_atk,
                              :sp_def, :speed, :generation, :legendary
            end
          end
          put '/' do
            poke = ::PokemonCrudService.new(nil, params).update

            poke.nil? ? error!("POkemon #{params[:id]}: don't existe", 404) : poke
          end
        end

        # DEL /api/v1/pokemons/
        route_param :id do
          desc 'Delete Pokemon by ID'
          params do
            requires :id, types: Integer, desc: 'ID of Pokemon.'
          end
          delete do
            poke = ::PokemonCrudService.new(nil, params).delete

            error!("Pokemon #{params[:id]}: don't exist", 404) if poke.nil?

            { "POkemon: #{poke.name} delete": 'ok' }
          end
        end

        # GET /api/v1/pokemons/search/ -- param name
        namespace :search do
          desc 'Search pokemon by name'
          params do
            requires :name, type: String, desc: 'Name of the Pokémon'
          end
          get do
            ::PokemonSearchService.search(declared(params))
          end
        end

        # GET /api/v1/pokemons/{id or name}
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
