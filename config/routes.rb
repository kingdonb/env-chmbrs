Rails.application.routes.draw do
  get 'index/main'

  root 'index#main'
end
