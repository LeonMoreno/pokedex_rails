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
            puts "session = #{cookies.inspect}"
            user = ::Users::AuthService.login(params)

            if user.nil?
              status :unauthorized
              { error: 'Invalid email or password' }
            else
              status :ok
              cookies[:algo] ||= 0
              cookies[:algo] = 1
              { algo: cookies[:algo] }
              # { OK: 'You are logged' }
            end
          end
        end
      end
    end
  end
end