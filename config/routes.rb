Elephant::Application.routes.draw do

  resources :bills


  get '/banks/new', controller: 'banks', action: 'new', as: 'new_bank'
  post '/banks', controller: 'banks', action: 'create'
  get '/banks', controller: 'banks', action: 'index', as: 'banks'
  get '/banks/:id', controller: 'banks', action: 'show', as: 'bank'
  get '/banks/:id/edit', controller: 'banks', action: 'edit', as: 'edit_bank'
  put '/banks/:id', controller: 'banks', action: 'update'
  delete '/banks/:id', controller: 'banks', action: 'destroy'
  #------------------------------

resources :users

root to: 'static_pages#home'

get '/help', controller: 'static_pages', action: 'help'
get '/about', controller: 'static_pages', action: 'about'
get '/contact', controller: 'static_pages', action: 'contact'

get '/login', controller: 'sessions', action: 'new'
post '/sessions', controller: 'sessions', action: 'create'
get '/logout', controller: 'sessions', action: 'destroy'

  # Routes for the User resource:
  # CREATE
  get '/users/new', controller: 'users', action: 'new', as: 'new_user'
  post '/users', controller: 'users', action: 'create'

  # READ
  get '/users', controller: 'users', action: 'index', as: 'users'
  get '/users/:id', controller: 'users', action: 'show', as: 'user'

  # UPDATE
  get '/users/:id/edit', controller: 'users', action: 'edit', as: 'edit_user'
  put '/users/:id', controller: 'users', action: 'update'

  # DELETE
  delete '/users/:id', controller: 'users', action: 'destroy'
  #------------------------------

  get '/', controller: 'static_pages', action: 'home'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
