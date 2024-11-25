json.extract! cliente, :id, :nome, :sexo, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
