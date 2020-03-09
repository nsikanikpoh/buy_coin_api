module Types
  class CalculatePriceType < Types::BaseObject
    field :price, Float, null: false
    field :currency, String, null:false
    field :type, String, null:false
    field :error, String, null:true
  end
end
