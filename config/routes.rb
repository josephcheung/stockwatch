Stockwatch::Application.routes.draw do
  scope :api do
    resources :stocks, only: [:index], defaults: {format: :json}
  end
  root 'watchlist#index'
end