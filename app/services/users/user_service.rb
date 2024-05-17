# frozen_string_literal: true

module Users
  class UserService
    attr_reader :params
    
    def initialize(params)
      @params = params
    end

    def create
      password = params[:password]
      email = params[:email]

      new_user = User.new(email: email, password: password)  
      
      new_user.save ? new_user : nil
    end
  end
end