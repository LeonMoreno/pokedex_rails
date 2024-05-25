# frozen_string_literal: true

module Api
  module V1
    class Authentication < Grape::API
      namespace :auth do
        namespace :login do
          desc 'User Login'
          params do
            requires :email, type: String, desc: 'User email'
            requires :password, type: String, desc: 'User password'
          end
          post '/' do
            token = ::Users::AuthService.new(params).login

            if token.nil?
              error!('unauthorized', 401)
            else
              # status :ok
              { token: }
            end
          end
        end
      end
    end
  end
end
