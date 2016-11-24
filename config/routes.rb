Rails.application.routes.draw do
  root "static_pages#home"
  get "/:page", to: "static_pages#show"
end
