Rails.application.routes.draw do

  get '/project/:id', to: 'projects#show', as: 'project'
  post '/project/:id' => 'projects#create_story'
  get 'projects/index'

  resources :projects

end
