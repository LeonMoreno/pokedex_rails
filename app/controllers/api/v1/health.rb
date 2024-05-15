# frozen_string_literal: true

module Api
  module V1
    class Health < Grape::API
    
      namespace :health do
        desc 'Return Ok'
        get '/' do
          { api: 'ok' }
        end
      end
    end
  end
end
