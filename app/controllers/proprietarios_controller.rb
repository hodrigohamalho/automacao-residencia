class ProprietariosController < ApplicationController

  before_filter :authenticate_usuario!

  respond_to :js
  respond_to :html, :only => :index

  def index
    @usuario = current_usuario

    if params[:id]
      @residencia = Residencia.find params[:id]

      if @residencia.usuario != @usuario
        flash[:error] = 'Você não possui permissão para visualizar a residência solicitada/'
        @residencia = @usuario.residencias.first
      end
    else
      @residencia = @usuario.residencias.first
    end
  end

  def alterar_estado
    @periferico = Periferico.find params[:id]
    if @periferico.comodo.residencia.usuario != current_usuario
      flash[:error] = 'Você não possui permissão para realizar a operação solicitada.'
    else
      @periferico.estado = !@periferico.estado
      @periferico.save
    end
  end

end

