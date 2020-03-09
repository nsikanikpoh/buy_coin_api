Rails.application.routes.draw do

  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post "/graph", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
