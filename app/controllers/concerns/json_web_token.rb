# frozen_string_literal: true

require "jwt"

module JsonWebToken
  # extended ActiveSupport::Concern
  
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode_token(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    puts "IN__JWT Empiezo"
    begin
      decode_token =  JWT.decode(token, SECRET_KEY)
      puts "IN__JWT decode_to = #{decode_token}"
      HashWithIndifferentAccess.new(decode_token[0])
    rescue JWT::DecodeError => e
      puts "error = #{e.message}"
      puts "Me voy por Rescur"
      nil
    end
  end

end