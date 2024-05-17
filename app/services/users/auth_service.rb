# frozen_string_literal: true

module Users
  class AuthService
    def self.login(params)
      email = params[:email]
      password = params[:password]

      user = User.find_by(email: email)
      user&.authenticate(password) ? user : nil
    end
  end
end