Rails.application.routes.draw do
  resources :lead
  post 'lead/get_collaterals' => 'lead#get_collaterals'
  resources :tag
  resources :collaterals
end
