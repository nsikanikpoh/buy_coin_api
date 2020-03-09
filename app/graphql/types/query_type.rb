require 'net/http'
require 'json'
URL = "https://api.coindesk.com/v1/bpi/currentprice/USD.json"

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    # User query
    field :calculate_price, Types::CalculatePriceType, null: false do
    
      description "calculated using the exchangeRate from Coindesk's API to retrieve the current price of Bitcoin"
    
      argument :type, String, required: true
      argument :margin, Float, required: true
      argument :exchange_rate, String, required: true
    end

    def calculate_price(type:, margin:, exchange_rate:)
      validate_request(type)
      validate_exchange_rate(exchange_rate)
      res = Net::HTTP.get_response(URI(URL)) 
      if res.is_a?(Net::HTTPSuccess)
        result = JSON.parse(res.body)
        { 
          price: calculate_margin(type, margin, result["bpi"]["USD"]["rate_float"], exchange_rate),
          currency: exchange_rate,
          type: type.downcase

         }
      else
        { error: "Coin Desk API Error" } # change here
      end
    end

    private 

    
    def calculate_margin(type, rate_float, margin, exchange_rate)
       if exchange_rate.downcase == "usa"
            return exchange(type, rate_float, margin)
      else
          return exchange(type, rate_float, margin) * 366.50 
       end
    end

    def exchange(type, rate_float, margin)
      if type.downcase == "sell"
            return rate_float - (margin * rate_float);
      elsif type.downcase == "buy"
            return rate_float + (margin * rate_float);   
       end
    end

    def validate_request(type)
      return if type.downcase == "buy" || type.downcase == "sell"
      raise GraphQL::ExecutionError,
            "invalid type, can only be buy or sell"
    end

     def validate_exchange_rate(type)
      return if type.downcase == "usa" || type.downcase == "ngn"
      raise GraphQL::ExecutionError,
            "invalid exchangeRate, we are only supporting USA or NGN"
    end




  end
end
