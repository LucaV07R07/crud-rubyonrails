require 'firebase'
require 'json'

base_uri = 'https://repositorio-de-sistemas-crud-default-rtdb.firebaseio.com/'  # URL correto do seu Firebase Realtime Database
credentials_path = Rails.root.join('config/firebase_credentials.json')  # Caminho para o arquivo de credenciais

# Ler o conteúdo do arquivo JSON como string e converter para hash
credentials = JSON.parse(File.read(credentials_path))

# Inicializar o cliente Firebase
$firebase = Firebase::Client.new(base_uri)
