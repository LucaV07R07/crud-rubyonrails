class Cliente
    include ActiveModel::Model
    attr_accessor :id, :nome, :email, :sexo
  
    validates :nome, presence: true
    validates :email, presence: true
    validates :sexo, presence: true
  
    def save_to_firebase
      return false unless valid?
  
      response = $firebase.push('clientes', to_hash)
      self.id = response.body['name']
      true
    end
  
    def update_to_firebase(attributes)
      attributes.each { |key, value| send("#{key}=", value) }
      return false unless valid?
  
      response = $firebase.update("clientes/#{id}", to_hash)
      response.success?
    end
  
    def destroy_from_firebase
      response = $firebase.delete("clientes/#{id}")
      response.success?
    end
  
    def to_hash
      { nome: nome, email: email, sexo: sexo }
    end
  
    def self.all
      response = $firebase.get('clientes')
      clientes = []
      response.body.each do |id, cliente_data|
        next unless cliente_data.is_a?(Hash)
        cliente_data['id'] = id
        clientes << Cliente.new(cliente_data)
      end
      clientes
    end
  end
  