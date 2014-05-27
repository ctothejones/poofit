Rails.application.routes.draw do

  devise_for :users

  root("pages#index")

  get("/profiles/:id", { :controller => "profiles", :action => "show" })

  get("/teams/:id", { :controller => "teams", :action => "show" })

  get("/matchups/:id", { :controller => "matchups", :action => "show" })



  get("/companies/new", { :controller => "companies", :action => "new" })
  post("/companies/create", { :controller => "companies", :action => "create" })
  get("/companies/:id", { :controller => "companies", :action => "show" })
  get("/companies/:id/edit", { :controller => "companies", :action => "edit" })
  ## Change to put or patch and update form method ##
  get("/companies/:id/update", { :controller => "companies", :action => "update" })

  get("/leagues/new", { :controller => "leagues", :action => "new" })
  post("/leagues/create", { :controller => "leagues", :action => "create" })
  get("/leagues/index", { :controller => "leagues", :action => "index" })
  get("/leagues/:id", { :controller => "leagues", :action => "show" })
  get("/leagues/:id/edit", { :controller => "leagues", :action => "edit" })
  ## Change to put or patch and update form method ##
  get("/leagues/:id/update", { :controller => "leagues", :action => "update" })
  delete("/leagues/:id/delete", { :controller => "leagues", :action => "destroy" })




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
