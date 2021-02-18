Rails.application.routes.draw do
  root :to => redirect('/collaterals')
  post 'search/get_collaterals' => 'leads#get_collaterals'
  get 'search', to: 'leads#search'
  devise_for :users
  resources :leads
  resources :tag
  resources :collaterals
end
