Rails.application.routes.draw do
  root 'stories#index'
  resources :stories
end
