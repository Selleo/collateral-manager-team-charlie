Rails.application.routes.draw do
  root :to => redirect('/collaterals')
  resources :lead
  resources :tag
  resources :collaterals
end
