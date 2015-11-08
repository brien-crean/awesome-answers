Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    # collection does not pass the id in the URL
    delete :destroy, on: :collection
    # options with member or with nothing will pass the id
    # sometimes we want to avoid this for security reasons especially with sessions
    # new for logging in, create for success login and destroy for logout
  end
  resources :questions do
    # 3 ways to write routes
    # this will generate a route and helper automatically:
    # 1.) get(:search, {on: :collection})
    # /questions/search with a path helper search_questions_path
    # 2.) get(:search, {on: :member})
    # /questions/:id/search (member => single record)
    # with no hash, this generates a nested resource route with helper question_search_path
    # 3.) get(:search)
    # /questions/:question_id/search

    # 'resources :answers' below makes all the answers routes nested within the questions so all
    # the standard answers urls will be prepended with
    # /questions/:question_id
    #
    resources :answers

  end
  # routes file is not aware of a controllers existence
  get "/index" => "welcome#index"

  # get "/greeting" => "welcome#greeting"

  get "greeting/:name" => "welcome#greeting"
  # get "greeting/:name" => "welcome#greeting", as: :greeting


  # OLD ROUTES
  #resources :questions => shortcut for all the question routes below
  # Routes below follow the rails standard conventions
  # get ({"/questions/new" => "questions#new", as: :new_question})
  # post ({"/questions" => "questions#create", as: :questions})
  # show a specific question
  # note that the priority is very important - this route will look for /questions/anything
  # if it has the highest
  # get ({"/questions/:id" => "questions#show", as: :question})
  #
  # get ({"/questions/:id/edit" => "questions#edit", as: :edit_question})
  # patch ({"/questions/:id" => "questions#update"}) # dont add as question for here as it will macth the show action
  # get ({"/questions" => "questions#index"})
  #
  # delete({"/questions/:id" => "questions#destroy"})
  #
  # This maps all GET requests with URL "/hello" to:
  #WelcomeController with Index action
  # format below: key => value key: :value
  get "/hello" => "welcome#hello", as: :hey
  # as option above allows to change the path name from the default 'hello_path' in this case

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'questions#index'

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
