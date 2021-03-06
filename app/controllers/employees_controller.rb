class EmployeesController < ApplicationController
  add_breadcrumb I18n.t('helpers.breadcrumbs.employees.index'), :employees_path

  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :load_permissions
  authorize_resource
  before_action :setup_menu, only: [:index]

  # configuracion del menu
  def setup_menu
    @menu_setup[:main_menu] = :person
    @menu_setup[:side_menu] = :employees_sidemenu
  end

  def search
    @employees = Employee.where('name ILIKE ?', "%#{params[:q][:term]}%")
    render json: {items: @employees, total_count: @employees.count}
  end

  # GET /employees
  # GET /employees.json
  def index
    get_employees
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    add_breadcrumb I18n.t('helpers.breadcrumbs.employees.show')
    @account_details = AccountEmployeeDetail.where(employee_id: @employee.id)
    @account = @employee.account_employee_details.page params[:page]
  end

  # GET /employees/new
  def new
    add_breadcrumb I18n.t('helpers.breadcrumbs.employees.new')
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    add_breadcrumb I18n.t('helpers.breadcrumbs.employees.edit')
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'El empleado se creo correctamente.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'El empleado se edito correctamente.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'El empleado se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def get_employees
      @q = Employee.ransack(params[:q])
      @q.sorts = ['name asc', 'last_name asc'] if @q.sorts.empty?
      @employees = @q.result.page(params[:page])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :last_name, :address, :email, :phone, :identification_document, :balance)
    end
end
