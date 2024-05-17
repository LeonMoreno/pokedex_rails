
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
          puts "Creando un NEW USER"
          user = ::Users::UserService.new(params).create
          
         if user.nil?
          status 422
          { "Errors": "Email #{params[:email]} already exist" }
         else
          user
         end
        end
      end
    end
  end
end