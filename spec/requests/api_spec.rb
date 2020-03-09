
require 'rails_helper'

RSpec.describe 'GrapghQl API', type: :request do
  # initialize test data

  # Test suite for GET /todos
  describe 'GET /graphiql exist' do
    # make HTTP get request before each example
    before { get '/graphiql' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


end
