Auditorium::Application.routes.draw do
  resources :users
  match 'register' => 'Users#new'
  match 'change_password' => 'Users#edit'

  resources :sessions
  match 'login'  => 'Sessions#new'
  match 'logout' => 'Sessions#destroy'

  resources :posts do
    resources :comments
  end

  root :to => "Posts#index"
end
