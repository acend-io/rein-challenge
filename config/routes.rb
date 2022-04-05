# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :drone_types, only: %i[index show create]
  resources :drones, only: %i[index show create]
  resources :pilots, only: %i[index show create]
end
