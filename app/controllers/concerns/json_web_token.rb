# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode_token(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decode_token = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(decode_token[0])
  rescue JWT::DecodeError
    nil
  end
end
