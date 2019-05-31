class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user

  # GET /employees
  # GET /employees.json
  def index
    session[:employee] = nil
    @employees = Employee.all.order(:id)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new(session[:employee] || {})
    @employee.build_profile_image
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.new(session[:employee]) if session[:employee]
    @employee.build_profile_image if @employee.profile_image.nil?
  end

  # POST /employees
  # POST /employees.json
  def create
    respond_to do |format|
      @employee = Employee.new(employee_params)
      if @employee.save
        session[:employee] = nil
        flash[:info] = ["登録しました。"]
        format.html { redirect_to @employee }
        format.json { render :show, status: :created, location: @employee }
      else
        session[:employee] = @employee.attributes.slice(*employee_params.keys)
        flash[:danger] = @employee.errors.full_messages
        format.html { redirect_to :new_employee }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(update_employee_params)
        session[:employee] = nil
        flash[:info] = ["更新しました。"]
        format.html { redirect_to @employee }
        format.json { render :show, status: :ok, location: @employee }
      else
        session[:employee] = @employee.attributes.slice(*employee_params.keys)
        flash[:danger] = @employee.errors.full_messages
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
      flash[:info] = ["削除しました。"]
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def login
    if !session[:user_id].nil?
      flash[:info] = ["すでにログインしています"]
      redirect_to employees_path
    end
  end

  def login_user
    if current_user = Employee.find_by(email: params[:email])
      if current_user = current_user.authenticate(params[:password])
        flash[:info] = ["ログインしました。"]
        session[:user_id] = current_user.id
        redirect_path = "/employees"
      else
        flash[:danger] = ["パスワードが違います。"]
        redirect_path = "/login"
      end
    else
      flash[:danger] = ["登録されていないEメールです。"]
      redirect_path = "/login"
    end

    redirect_to redirect_path
  end

  def logout
    if !session[:user_id].nil?
      session[:user_id] = nil
      flash[:info] = ["ログアウトしました。"]
      redirect_to root_path
    else
      flash[:danger] = ["不正な操作です。"]
      redirect_to root_path
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
      params.require(:employee).permit(:name, :join_date, :gender_id, :email, profile_image_attributes: [:image])
        .merge(position: (position.empty? ? "なし" : position), password: " ", password_confirmation: " ")
    end

    def update_employee_params
      position = params[:employee][:position]
      params.require(:employee).permit(:name, :join_date, :gender_id, :email, profile_image_attributes: [:image, :_destroy, :id]).merge(position: (position.empty? ? "なし" : position))
    end

    def set_current_user
      @current_user = Employee.find_by_id(session[:user_id])
    end
end
