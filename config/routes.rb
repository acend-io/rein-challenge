# frozen_string_literal: true

Rails.application.routes.draw do
  resources :drone_types, only: %i[index show create]
  resources :drones, only: %i[index show create]
  resources :pilots, only: %i[index show create]
end
