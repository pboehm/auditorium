Auditorium::Application.routes.draw do
  resources :users
  match 'signup' => 'Users#new'

  resources :sessions
  match 'login'  => 'Sessions#create'
  match 'logout' => 'Sessions#destroy'

  resources :posts do
    resources :comments
  end

  root :to => "Posts#index"
end
