Rails.application.routes.draw do
  root to: 'pages#home'
  resource :museums
  post '/', to: 'museums#search'
end
