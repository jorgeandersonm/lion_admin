Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'auditors/login', to: 'auditors#login'
  post 'auditors/login', to: 'auditors#sign_in'

  get 'auditors/individuals/', to: 'auditors#individuals_by_city_report', as: :individuals_by_city_report
  get 'auditors/individuals_by_goods_value', to: 'auditors#individuals_by_goods_value_report'

  root 'auditors#index'
end
