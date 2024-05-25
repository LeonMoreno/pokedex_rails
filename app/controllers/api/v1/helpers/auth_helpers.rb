# frozen_string_literal: true

module Api
  module V1
    module Helpers
      module AuthHelpers
        include JsonWebToken

        def current_user(decoded_token)
          return nil if decoded_token.nil?

          user_id = decoded_token[:user_id]
          User.find_by(id: user_id)
        end

        def get_token(request)
          header = request.headers['authorization']
          header.split[1] if header
        end

        def authorize_request(request)
          token = get_token(request)

          decoded_token = decode_token(token)

          error!('401 Unauthenticated', 401) unless current_user(decoded_token)
        end
      end
    end
  end
end
