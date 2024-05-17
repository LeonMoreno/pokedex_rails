# frozen_string_literal: true

module Api
  class Base < Grape::API
    prefix 'api'
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    error_formatter :json, Grape::Formatter::ActiveModelSerializers
    
    get '/' do
      status :no_content
    end
    
    # /api/v1/hello
    namespace :hello do
      desc 'Return Ok'
      get do
        puts 'Hola mi LEO /'
        { api: 'HOLA'}
      end
    end
    
    mount V1::Health
    mount V1::Pokemons
    mount V1::Users
    mount V1::Authentication
  end
end