Rails.application.routes.draw do

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post "/graph", to: "graphql#execute"
  root 'graphql#index'
  root 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
