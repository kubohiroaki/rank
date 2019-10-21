Rails.application.routes.draw do

  # get '/sign_up', to: 'users#sign_up', as: :sign_up
  # post '/sign_up', to: 'users#sign_up_process'
  get '/sign_in', to: 'users#sign_in', as: :sign_in
  post '/sign_in', to: 'users#sign_in_process'
  get '/sign_out', to: 'users#sign_out', as: :sign_out
  resources :movies 
    root 'movies#index' #トップページをmoviesコントローラのindexアクションに設定
    get '/search_result', to: 'movies#search_result'
    post 'movies/next', to: 'movies#next'
    post 'movies/next2', to: 'movies#next_story'
    post 'movies/next3', to: 'movies#next_comedy'
    post 'movies/next4', to: 'movies#next_emotion'
    post 'movies/next5', to: 'movies#next_fiction'
    get 'like/(:id)', to: 'movies#like', as: :like 

  
  get '/top', to: 'ranking#top'
  get 'ranking/type', to: 'ranking#type', as: :type
  get 'contents/show', to: 'contents#show', as: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
