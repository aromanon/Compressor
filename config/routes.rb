Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  root to: 'images#index'
  post '/images/compress', to: 'images#compress'
  get '/images/:uuid/download', to: 'images#download', as: 'image_download'
end
