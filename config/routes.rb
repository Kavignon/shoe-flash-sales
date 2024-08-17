# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'stores#index'

  resources :stores, only: %i[index show] do
    resources :shoes, only: %i[index show]
    resources :orders, only: [:create]
  end
end
