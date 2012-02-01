Tdg::Application.routes.draw do
  get "users/new"

  get "sessions/new"

  get "home/index"
  
  match "users/forgot_password"
  match "users/reset_password/:reset_token", :to => "users#reset_password"
  match "users/send_password_reset"
  match "users/update_password"

  get 'tasks/archived', :to => 'tasks#archived', :as => 'archived_tasks'

  resources :tasks do
    collection do
      post :sort
    end
  end

  get 'tasks/:id/complete', :to => 'tasks#complete', :as => 'complete_task'
  get 'tasks/:id/uncomplete', :to => 'tasks#uncomplete', :as => 'uncomplete_task'
  get 'tasks/:id/archive', :to => 'tasks#archive', :as => 'archive_task'
  get 'tasks/:id/unarchive', :to => 'tasks#unarchive', :as => 'unarchive_task'
  get 'tasks/:id/tick_pom', :to => 'tasks#tick_pom', :as => 'tick_pom_task'
  get 'tasks/:id/untick_pom', :to => 'tasks#untick_pom', :as => 'untick_pom_task'
  get 'tasks/:id/add_estimated_pom', :to => 'tasks#add_estimated_pom', :as => 'add_estimated_pom_task'
  get 'tasks/:id/remove_estimated_pom', :to => 'tasks#remove_estimated_pom', :as => 'remove_estimated_pom_task'
  get 'tasks/tag/:tag', :to => 'tasks#index', :as => 'tagged_tasks'

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  get "signup" => "users#new", :as => "signup"

  resources :tags
  resources :users
  resources :sessions

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
