Rails.application.routes.draw do

  root to: "/orden_trabajos/:orden_trabajo_id", to: "orden_trabajos#index"
  resources :orden_trabajos
  get '/orden_trabajos/:id/copy', to: 'orden_trabajos#copy', as: :copy


  get 'proximo_vencer', to: 'orden_trabajos#proximo_vencer', as: :proximo_vencer
  get 'planificacionTaller', to: 'orden_trabajos#planificacionTaller', as: :planificacionTaller
  get 'planificacionTallerPDF', to: 'orden_trabajos#planificacionTallerPDF', as: :planificacionTallerPDF


  # Rutas creadas para cada pantalla

    get 'listado', to: 'orden_trabajos#listado', as: :listado
    get 'offset1', to: 'orden_trabajos#offset1', as: :offset1
    get 'offset2', to: 'orden_trabajos#offset2', as: :offset2
    get 'digital', to: 'orden_trabajos#digital', as: :digital
    get 'post1', to: 'orden_trabajos#post1', as: :post1
    get 'post2', to: 'orden_trabajos#post2', as: :post2
    get 'post3', to: 'orden_trabajos#post3', as: :post3
    get 'post4', to: 'orden_trabajos#post4', as: :post4
    get 'post5', to: 'orden_trabajos#post5', as: :post5
    get 'post6', to: 'orden_trabajos#post6', as: :post6
    get 'post7', to: 'orden_trabajos#post7', as: :post7
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :orden_trabajos_imports, only: [:new, :create]
  get 'orden_trabajos_imports/new'
  get 'orden_trabajos_imports/create'


end


