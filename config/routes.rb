Rails.application.routes.draw do
  root :to => redirect('/collaterals')

  devise_for :users
  resources :leads
  resources :tag
  resources :collaterals
end
