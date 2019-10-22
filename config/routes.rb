Rails.application.routes.draw do

resources :contacts, only: [:new, :create]
  get '/se', to: 'movies#se', as: :se
  # get '/sign_up', to: 'users#sign_up', as: :sign_up
  # post '/sign_up', to: 'users#sign_up_process'
  get '/sign_in', to: 'users#sign_in', as: :sign_in
  post '/sign_in', to: 'users#sign_in_process'
  get '/sign_out', to: 'users#sign_out', as: :sign_out
  get '/profile', to: 'users#show', as: :profile_show
  get '/profile/edit', to: 'users#edit', as: :profile_edit
  post '/profile/edit', to: 'users#update'
  resources :movies 
    root 'movies#index' #トップページをmoviesコントローラのindexアクションに設定
    get '/search_result', to: 'movies#search_result'
    post 'movies/next', to: 'movies#next'
    post 'movies/prev', to: 'movies#prev'
    post 'movies/next2', to: 'movies#next_story'
    post 'movies/prev2', to: 'movies#prev_story'
    post 'movies/next3', to: 'movies#next_comedy'
    post 'movies/prev3', to: 'movies#prev_comedy'
    post 'movies/next4', to: 'movies#next_emotion'
    post 'movies/prev4', to: 'movies#prev_emotion'
    post 'movies/next5', to: 'movies#next_fiction'
    post 'movies/prev5', to: 'movies#prev_fiction'    
  get 'like/(:id)', to: 'movies#like', as: :like 
  get 'maxim(:id)', to: 'movies#maxim', as: :maxim
  get 'love', to: 'movies#love', as: :love

  
  get '/top', to: 'ranking#top'
  get 'ranking/type', to: 'ranking#type', as: :type
  get 'contents/show', to: 'contents#show', as: :show

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
