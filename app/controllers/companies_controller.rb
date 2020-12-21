class CompaniesController < ApplicationController
  before_action :get_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to companies_path, notice: 'Company created successfully'
    else
      flash[:error] = "Company creation failed: #{@company.errors.full_messages.join('\n')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: 'Changes updated successfully'
    else
      flash[:error] = "Company modification failed: #{@company.errors.full_messages.join('\n')}"
      render :edit
    end
  end

  def destroy
    if @company.destroy
      flash[:notice] = "#{@company.name} is been deleted successfully"
    else
      flash[:error] = "Sorry unable to delete #{@company.name}"
    end

    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
      :brand_color,
      services: []
    )
  end

  def get_company
    @company = Company.find(params[:id]) rescue nil

    if @company.nil?
      flash[:error] = "Company not found with specified id: #{params[:id]}"
      redirect_to companies_path
    end
  end
end #__End of class 'CompaniesController'__
