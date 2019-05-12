class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    session[:employee] = nil
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @title = "詳細"
  end

  # GET /employees/new
  def new
    @employee = Employee.new(session[:employee] || {})
    @title = "新規登録"
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.new(session[:employee]) if session[:employee]
    @title = "編集"
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        session[:employee] = nil
        flash[:info] = "登録しました。"
        format.html { redirect_to @employee }
        format.json { render :show, status: :created, location: @employee }
      else
        session[:employee] = @employee.attributes.slice(*employee_params.keys)
        flash[:danger] = @employee.errors.keys.map { |key| [key, @employee.errors.full_messages_for(key)] }.to_h 
        format.html { redirect_to :new_employee }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        session[:employee] = nil
        flash[:info] = "更新しました。"
        format.html { redirect_to @employee }
        format.json { render :show, status: :ok, location: @employee }
      else
        session[:employee] = @employee.attributes.slice(*employee_params.keys)
        flash[:danger] = @employee.errors.keys.map { |key| [key, @employee.errors.full_messages_for(key)] }.to_h 
        format.html { redirect_to :edit_employee }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      flash[:info] = "削除しました。"
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      position = params[:employee][:position]
      params.require(:employee).permit(:name, :join_date, :gender_id, :email).merge(position: (position.empty? ? "なし" : position))
    end
end
