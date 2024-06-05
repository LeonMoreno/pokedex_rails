# frozen_string_literal: true

module Users
  class UserService
    include JsonWebToken
    attr_reader :params

    def initialize(params = nil)
      @params = params
    end

    def create
      password = params[:password]
      email = params[:email]

      new_user = User.new(email:, password:)

      new_user.save ? make_response(new_user) : nil
    end

    def make_response(new_user)
      token = encode_token(user_id: new_user.id)

      {
        user: ActiveModelSerializers::SerializableResource.new(new_user),
        token:
      }.compact
    end
  end
end
