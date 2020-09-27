Rails.application.routes.draw do

  root to: 'orden_trabajos#index'
  resources :orden_trabajos

  resources :orden_trabajos_imports, only: [:new, :create]
  get 'orden_trabajos_imports/new'
  get 'orden_trabajos_imports/create'

# Rutas creadas para cada pantalla
  get 'listado', to: 'orden_trabajos#listado', as: :listado
  

end
