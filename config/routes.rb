#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  constraints(-> (req) { req.env["HTTP_USER_AGENT"] !~ /Firefox/ }) do
    get 'admin' => 'admin#index'
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end
    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    resources :products, path: :books do
      get :who_bought, on: :member, format: 'atom'
    end
    resources :users do
      resources :orders
      resources :line_items
    end
    resources :support_requests, only: [ :index, :update ]

    scope '(:locale)' do
      resources :orders
      resources :line_items
      resources :carts
      root 'store#index', via: :all
    end

    namespace :admin do
      resources :reports
      resources :categories
    end

    resources :categories do
      resources :products, path: :books
    end


    get 'my-orders', to: 'users#my_orders'
    get 'my-items', to: 'users#my_items'
  end

  # For details on the DSL available within this file, see
  # https://guides.rubyonrails.org/routing.html
end

