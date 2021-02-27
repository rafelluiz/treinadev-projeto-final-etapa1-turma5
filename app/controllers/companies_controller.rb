class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update]
  before_action :authenticate_collaborator!, only: %i[edit update]

  def index
    @companies = Company.all
  end

  def show;end

  def edit;end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit,notice: 'Company was not updated.'
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :site, :twitter, :facebook, :instagram,
                                    :linkedin, :email_domain, :email,:logo)
  end
end