# frozen_string_literal: true

module Api
  module V1
    class Health < Grape::API
      namespace :health do
        desc 'Return Ok'
        before { authorize_request(request) }
        get '/' do
          { api: 'ok' }
        end
      end
    end
  end
end
