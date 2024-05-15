require 'rails_helper'

RSpec.describe 'Up Health API', type: :request do
  describe 'GET /up' do
    before { get '/up' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
