# frozen_string_literal: true

Rails.application.routes.draw do
  resources :drone_types, only: %i[index show create]
  resources :drones, only: %i[index show create]
  resources :checkouts, only: %i[index create], controller: 'pilot_drone_checkouts'
  resources :pilots, only: %i[index show create] do
    member do
      post :checkout
    end
  end
end
