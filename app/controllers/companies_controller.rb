class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new
    @company.name = params[:company][:name]
    @company.save

    if @company.save
      redirect_to "/companies/#{@company.id}", :notice => "Company created successfully."
    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.name = params[:company][:name]

    @company.save

    if @company.save
      redirect_to "/companies/#{@company.id}", :notice => "Company updated successfully."
    else
      render 'edit'
    end
  end
end
