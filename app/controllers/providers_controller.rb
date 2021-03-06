class ProvidersController < ApplicationController
  add_breadcrumb I18n.t('helpers.breadcrumbs.providers.index'), :providers_path

  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  before_action :load_permissions
  authorize_resource
  before_action :setup_menu, only: [:index]

  # configuracion del menu
  def setup_menu
    @menu_setup[:main_menu] = :person
    @menu_setup[:side_menu] = :providers_sidemenu
  end

  def search
    @providers = Provider.where('name ILIKE ?', "%#{params[:q][:term]}%")
    render json: {items: @providers, total_count: @providers.count}
  end
  # GET /providers
  # GET /providers.json
  def index
    get_providers
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    add_breadcrumb I18n.t('helpers.breadcrumbs.providers.show')
    @purchase_bills = @provider.purchase_bills.page params[:page]
  end

  # GET /providers/new
  def new
    add_breadcrumb I18n.t('helpers.breadcrumbs.providers.new')
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
    add_breadcrumb I18n.t('helpers.breadcrumbs.providers.edit')
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_url, notice: 'El proveedor se creo correctamente.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to providers_url, notice: 'El proveedor se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'El proveedor se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def get_providers
      @q = Provider.ransack(params[:q])
      @q.sorts = ['name asc'] if @q.sorts.empty?
      @providers = @q.result.page(params[:page])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :ruc, :address, :phone, :email, :state, :balance)
    end
end
