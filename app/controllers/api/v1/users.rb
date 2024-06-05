# frozen_string_literal: true

module Api
  module V1
    class Users < Grape::API
      resource :users do
        desc 'Create new User'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post '/' do
          response = ::Users::UserService.new(params).create

          error!("Email #{params[:email]} already exist", 422) if response.nil?
          response
        end
      end
    end
  end
end
