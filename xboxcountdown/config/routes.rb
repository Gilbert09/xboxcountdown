Rails.application.routes.draw do

    root :to => 'game#index'

    get 'publisher' => 'publisher#index', as: 'publisher_all'
    get 'publisher/:id' => 'publisher#get', as: 'publisher_get'

    get 'game/:id' => 'game#get', as: 'game_get'
    post 'game/create' => 'game#create', as: 'game_create'

    get 'dashboard' => 'dashboard#index', as: 'dashboard'
    get 'dashboard/games' => 'dashboard#games', as: 'dashboard_games'
    get 'dashboard/games/add' => 'dashboard#addGame', as: 'dashboard_games_add'
    post 'dashboard/games/add' => 'dashboard#createGame', as: 'dashboard_games_add_save'
    get 'dashboard/game/:id/edit' => 'dashboard#editGame', as: 'dashboard_game_edit'
    post 'dashboard/game/:id/edit' => 'dashboard#saveGame', as: 'dashboard_game_edit_save'
    get 'dashboard/game/:id/view' => 'dashboard#viewGame', as: 'dashboard_game_view'
    get 'dashboard/games/queue' => 'dashboard#gameQueue', as: 'dashboard_game_queue'
    get 'dashboard/games/queue/:id/accept' => 'dashboard#gameAccept', as: 'dashboard_game_queue_accept'

    get 'api/games' => 'api#index', as: 'api_games'

    get 'import' => 'dashboard#import'


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
