Rails.application.routes.draw do
  
  root 'welcome#index'
  get '/project/:id', to: 'projects#show', as: 'project'
  post '/project/:id' => 'projects#create_story'
  get 'projects/index'

  resources :projects

end
