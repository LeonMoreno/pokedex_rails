# frozen_string_literal: true

module Users
  class AuthService
  include JsonWebToken
  attr_reader :email, :password

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def login
    user = User.find_by(email: email)

    user&.authenticate(password) ? encode_token(user_id: user.id) : nil
  end
  end
end
