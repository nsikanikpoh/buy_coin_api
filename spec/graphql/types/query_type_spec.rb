# spec/graphql/types/query_type_spec.rb
require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  describe "POST #execute" do


    it 'returns status code 200' do
      post :execute, params: { query: read_query } 
      expect(response).to have_http_status(200)
    end

 
      it "returns expected exchangeRate" do
        post :execute, params: { query: read_query } 
        json = JSON.parse(response.body)
        expect(json.dig('data', 'calculatePrice', 'currency')).to eql 'NGN'
      end

        
     it "returns a price as float type" do
           post :execute, params: { query: read_query } 
          json = JSON.parse(response.body)
          expect(json.dig('data', 'calculatePrice', 'price').is_a? Float).to eql true
        end

    def read_query
        <<~GQL
          query {
            calculatePrice(type: "buy", margin: 0.2, exchangeRate: "NGN")
             {
              price
              currency
              type
            }
          }
        GQL
   end


  end
end


  