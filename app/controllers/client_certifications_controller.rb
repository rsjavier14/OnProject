class ClientCertificationsController < ApplicationController
  add_breadcrumb I18n.t('helpers.breadcrumbs.client_certifications.index'), :client_certifications_path

  before_action :set_client_certification, only: [:show, :edit, :update, :destroy]
  before_action :load_permissions
  authorize_resource
  before_action :setup_menu, only: [:index]

  # configuracion del menu
  def setup_menu
    @menu_setup[:main_menu] = :contract
    @menu_setup[:side_menu] = :client_certificacions_sidemenu
  end

  # GET /client_certifications
  # GET /client_certifications.json
  def get_detail
    render :json => ClientCertification.find(params[:id])
  end

  def index
    get_client_certifications
  end

  # GET /client_certifications/1
  # GET /client_certifications/1.json
  def show
    add_breadcrumb I18n.t('helpers.breadcrumbs.client_certifications.show')
  end

  # GET /client_certifications/new
  def new
    add_breadcrumb I18n.t('helpers.breadcrumbs.client_certifications.new')
    @client_certification = ClientCertification.new
    @client_certification.contract_id = params[:contract_id]
    @client_certification.date = Time.now
    @client_certification.client_certification_details.build
  end

  # GET /client_certifications/1/edit
  def edit
    add_breadcrumb I18n.t('helpers.breadcrumbs.client_certifications.edit')
  end

  # POST /client_certifications
  # POST /client_certifications.json
  def create
    @client_certification = ClientCertification.new(client_certification_params)

    respond_to do |format|
      if @client_certification.save
        format.html { redirect_to @client_certification.contract, notice: 'La Certificación se creó correctamente' }
        format.json { render :show, status: :created, location: @client_certification }
      else
        format.html { render :new }
        format.json { render json: @client_certification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_certifications/1
  # PATCH/PUT /client_certifications/1.json
  def update
    respond_to do |format|
      if @client_certification.update(client_certification_params)
        format.html { redirect_to client_certifications_path, notice: 'La Certificación se actualizó correctamente.' }
        format.json { render :show, status: :ok, location: @client_certification }
      else
        format.html { render :edit }
        format.json { render json: @client_certification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_certifications/1
  # DELETE /client_certifications/1.json
  def destroy
    @client_certification.destroy
    respond_to do |format|
      format.html { redirect_to client_certifications_url, notice: 'La Certificación se eliminó correctamente' }
      format.json { head :no_content }
    end
  end

  private
  def get_client_certifications
    @q = ClientCertification.ransack(params[:q])
    @q.sorts = ['date desc', 'contract_name asc', 'state asc'] if @q.sorts.empty?
    @client_certifications = @q.result.page(params[:page])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_client_certification
    @client_certification = ClientCertification.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_certification_params
    params.require(:client_certification).permit(:contract_id, :date, :state, :observation, :received, :contract, :number,
                                                 :client_certification_details_attributes => [:id, :budget_detail_id, :quantity, :total_quantity, :price, :total, :_destroy])
  end
end
