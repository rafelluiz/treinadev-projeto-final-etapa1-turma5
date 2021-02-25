class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update]
  before_action :authenticate_collaborator!

  def show;end

  def edit;end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :site, :twitter, :facebook, :instagram,
                                    :linkedin, :email_domain, :email)
  end
end