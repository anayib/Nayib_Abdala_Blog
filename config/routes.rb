Rails.application.routes.draw do

  get 'suscriptors/new'

  mount Ckeditor::Engine => '/ckeditor'
  # namespace :admin do
  #   resources :user
  # end

  #namespace => cuando hay diversos roles que tienen derechos para ciertos modelos ej divise:index
  #en esto se podría crear otro controlador con otronombre que le pegue al mismo modelo
  #la buena practica es crear el namespace

  # namespace :admin do
  #   resources :users
  # end   en controllers deberia crear una carpeta con nombre admin y un controlador users_controller y en las vistas tambien
  #crear acarpeta admin y products.

  # ej para apis
  # # namespace :api do
  #   resources :users, :xxxx, :rrrr
  # end

  root 'landing_page#landing'

  get 'landing_page/about'

  #get 'landing_page/pricing_plans'

  get 'landing_page/wire_explanation'

  get 'landing_page/cancelar_cuenta'

  get 'landing_page/enterprise'

  get 'landing_page/contact'

  get 'suscriptors/contactpayment'

  get 'landing_page/privacyandterms'
  get 'landing_page/landing_corporate'
  get 'landing_page/landing_universities'



  #get 'namequequieraparaurl' => 'controller#action', as: 'el alias del path'


  devise_for :users

  resources :categories

  resources :tips

  resources :authors

  resources :strategies

  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#unprocessable_entity'
  match '/500', via: :all, to: 'errors#server_error'

  #rutas anidadas
  # #resources :articles do
  #   resources :comments
  # end      cuando se hace esto se deben modificar los forms en create pasandole los parametros de los dos





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
