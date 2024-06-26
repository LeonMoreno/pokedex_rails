# frozen_string_literal: true

module Api
  class Base < Grape::API
    helpers V1::Helpers::AuthHelpers

    prefix 'api'
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    get '/' do
      status :no_content
    end

    mount V1::Health
    mount V1::Pokemons
    mount V1::PokemonsList
    mount V1::Users
    mount V1::Authentication
  end
end
