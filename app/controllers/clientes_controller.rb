class ClientesController < ApplicationController
  def index
    @clientes = Cliente.all
  end

  def show
    @cliente = Cliente.all.find { |c| c.id == params[:id] }
  end

  def new
    @cliente = Cliente.new
  end

  def create
    @cliente = Cliente.new(cliente_params)
    if @cliente.save_to_firebase
      redirect_to cliente_path(@cliente.id), notice: 'Cliente criado com sucesso.'
    else
      render :new
    end
  end

  def edit
    @cliente = Cliente.all.find { |c| c.id == params[:id] }
  end

  def update
    @cliente = Cliente.all.find { |c| c.id == params[:id] }
    if @cliente.update_to_firebase(cliente_params)
      redirect_to cliente_path(@cliente.id), notice: 'Cliente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @cliente = Cliente.all.find { |c| c.id == params[:id] }
    Rails.logger.info("Cliente encontrado: #{@cliente.id}")  # Loga o ID do cliente
    if @cliente.destroy_from_firebase
      Rails.logger.info("Cliente deletado: #{@cliente.id}")  # Loga o sucesso da deleção
      redirect_to clientes_path, notice: 'Cliente deletado com sucesso.'
    else
      Rails.logger.error("Erro ao deletar cliente: #{@cliente.id}")  # Loga o erro na deleção
      redirect_to clientes_path, alert: 'Erro ao deletar o cliente.'
    end
  end

  private

  def cliente_params
    params.require(:cliente).permit(:nome, :email, :sexo)
  end
end
