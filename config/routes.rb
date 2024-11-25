Rails.application.routes.draw do
  resources :clientes  # Inclui a rota para todas as ações, incluindo destroy
  root 'clientes#index'  # Define a rota raiz para a lista de clientes
end
