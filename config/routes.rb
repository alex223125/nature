# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :species
  # resources :occurrences
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  get '/species/map' => 'species#map', :as => :map

  namespace :api do
    namespace :v1 do
      post '/occurrences/presence' => 'occurrences#presence', :as => :presence
      get '/species/map' => 'species#map', :as => :map
    end
  end
end
