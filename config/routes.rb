Rails.application.routes.draw do
  root :to => redirect('/collaterals')
  post 'lead/get_collaterals' => 'lead#get_collaterals'
  devise_for :users
  resources :leads
  resources :tag
  resources :collaterals
end
