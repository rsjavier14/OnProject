class PurchaseBillsController < ApplicationController
  add_breadcrumb I18n.t('helpers.breadcrumbs.purchase_bills'), :purchase_bills_path

  before_action :set_purchase_bill, only: [:show, :edit, :update, :destroy]
  before_action :load_permissions
  authorize_resource

  # GET /purchase_bills
  # GET /purchase_bills.json
  def index
    get_purchases
  end

  # GET /purchase_bills/1
  # GET /purchase_bills/1.json
  def show
  end

  # GET /purchase_bills/new
  def new
    @purchase_bill = PurchaseBill.new
  end

  # GET /purchase_bills/1/edit
  def edit
  end

  # POST /purchase_bills
  # POST /purchase_bills.json
  def create
    @purchase_bill = PurchaseBill.new(purchase_bill_params)

    respond_to do |format|
      if @purchase_bill.save
        format.html { redirect_to purchase_bills_url, notice: 'La factura de compra ha sido creada correctamente.' }
        format.json { render :show, status: :created, location: @purchase_bill }
      else
        format.html { render :new }
        format.json { render json: @purchase_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_bills/1
  # DELETE /purchase_bills/1.json
  def destroy
    @purchase_bill.destroy
    respond_to do |format|
      format.html { redirect_to purchase_bills_url, notice: 'Purchase bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_purchases
      @q = PurchaseBill.ransack(params[:q])
      @q.sorts = ['date desc'] if @q.sorts.empty?
      @purchase_bills = @q.result.page(params[:page])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_bill
      @purchase_bill = PurchaseBill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_bill_params
      params.require(:purchase_bill).permit(:date, :condition, :number, :provider_id,
                                            :purchase_details_attributes => [:id, :quantity, :material_id, :price, :_destroy])
    end
end
