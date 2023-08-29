# frozen_string_literal: true

Rails.application.routes.draw do
  get '/species/map' => 'species#map', :as => :map

  namespace :api do
    namespace :v1 do
      post '/occurrences/presence' => 'occurrences#presence', :as => :presence
      get '/species/map' => 'species#map', :as => :map
    end
  end
end
