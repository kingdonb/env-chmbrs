Rails.application.routes.draw do
  get 'health/ok'

  get 'index/main'
  get '_health', to: 'health#ok'

  root 'index#main'
end
