CoreDoc::Application.routes.draw do
  namespace :api do
    resources :documents, except: [:edit, :new]
  end

  get '*foo', :to => 'core_doc#index'
  get '/', :to => 'core_doc#index'
end
