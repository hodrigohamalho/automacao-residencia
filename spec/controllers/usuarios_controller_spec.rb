require 'spec_helper'
include Devise::TestHelpers

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe UsuariosController do

  before do
    @usuario = Factory :usuario, :nome => 'Rodrigo e Karina'    
    
    sign_in @usuario 
  end

  def mock_usuario(stubs={})
    @mock_usuario ||= mock_model(Usuario, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all usuarios as @usuarios" do
      get :index
      assigns(:usuarios).member?(@usuario).should be_true
    end
  end

  describe "GET show" do
    context 'quando possuir varias residencias' do
      it "deveria redirecionar para o show de usuario" do
        usuario = Factory.create :usuario
        residencia = Factory.create :residencia, :usuario => usuario
        Factory.create :residencia, :usuario => usuario
      
        residencia.usuario.residencias.size.should > 1
        get :show, :id => residencia.usuario.id
        response.should render_template :show
      end
    end
    
    context 'quando existir apenas uma residencia' do
      it 'deveria redirecionar para o show de residencia' do
        residencia = Factory.create :residencia
        
        residencia.usuario.residencias.size.should == 1
        get :show, :id => residencia.usuario.id
        response.should redirect_to(usuario_residencia_path(residencia.usuario, residencia))
      end
    end
  end

  describe "GET new" do
    it "assigns a new usuario as @usuario" do
      Usuario.stub(:new) { mock_usuario }
      xhr :get, :new
      assigns(:usuario).should be(mock_usuario)
    end
  end

  describe "GET edit" do
    it "assigns the requested usuario as @usuario" do
      Usuario.stub(:find).with("37") { mock_usuario }
      get :edit, :id => "37"
      assigns(:usuario).should be(mock_usuario)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created usuario as @usuario" do
        Usuario.stub(:new).with({'these' => 'params'}) { mock_usuario(:save => true) }
        xhr :post, :create, :usuario => {'these' => 'params'}
        assigns(:usuario).should be(mock_usuario)
        assigns(:show_password?).should be_false
      end

      it "deveria redirecionar para ? depois que o usuario for criado"
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved usuario as @usuario" do
        Usuario.stub(:new).with({'these' => 'params'}) { mock_usuario(:save => false) }
        xhr :post, :create, :usuario => {'these' => 'params'}
        assigns(:usuario).should be(mock_usuario)
      end

      it "deveria redirecionar para ? depois que o usuario for criado"
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested usuario" do
        Usuario.stub(:find).with("37") { mock_usuario }
        mock_usuario.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :usuario => {'these' => 'params'}
      end

      it "assigns the requested usuario as @usuario" do
        Usuario.stub(:find) { mock_usuario(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:usuario).should be(mock_usuario)
      end

      it "redirects to the usuario" do
        Usuario.stub(:find) { mock_usuario(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(usuario_url(mock_usuario))
      end
    end

    describe "with invalid params" do
      it "assigns the usuario as @usuario" do
        Usuario.stub(:find) { mock_usuario(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:usuario).should be(mock_usuario)
      end

      it "re-renders the 'edit' template" do
        Usuario.stub(:find) { mock_usuario(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested usuario" do
      Usuario.stub(:find).with("37") { mock_usuario }
      mock_usuario.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the usuarios list" do
      Usuario.stub(:find) { mock_usuario }
      delete :destroy, :id => "1"
      response.should redirect_to(usuarios_url)
    end
  end

end
