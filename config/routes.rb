Auditorium::Application.routes.draw do
  get "ebooks/index"

  resources :users
  match 'register' => 'Users#new'
  match 'settings' => 'Users#edit'

  resources :sessions
  match 'login'  => 'Sessions#new'
  match 'logout' => 'Sessions#destroy'

  resources :posts do
    resources :comments
  end

  resources :events

  resources :ebooks

  root :to => "Posts#index"
end
