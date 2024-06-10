# frozen_string_literal: true

module Api
  module V1
    class Pokemons < Grape::API
      namespace :pokemons do
        before { authorize_request(request) }

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
        post do
          poke = ::PokemonCrudService.new(nil, declared(params)).create

          poke.nil? ? error!("POkemon #{params[:pokemon][:name]} already exist", 409) : poke
        end

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
      end
    end
  end
end
