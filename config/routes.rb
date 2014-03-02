Stockwatch::Application.routes.draw do
  scope :api do
    resources :stocks, defaults: {format: :json}
  end
  root 'watchlist#index'
end