Rails.application.routes.draw do

  get 'bookmarks/show'

  get 'bookmarks/new'

  get 'bookmarks/edit'

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  resources :topics do
    resources :bookmarks
  end

  post :incoming, to: 'incoming#create'

  root 'welcome#index'
end
