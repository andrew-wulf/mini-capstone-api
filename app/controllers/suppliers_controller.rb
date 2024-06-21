class SuppliersController < ApplicationController
  before_action :check_admin, before: [:create, :update, :destroy]
  
  def index
    @suppliers = Supplier.all
    render :index
  end

  def show
    @supplier = Supplier.find_by(id: params[:id])
    if @supplier
      render :show
    else
      render json: {message: 'No item exists at this index.'}
    end
  end

  def create
    @supplier = Supplier.new(name: params[:name], 
    email: params[:email], 
    phone_number: params[:phone_number])

    if @supplier.save
      render :show
    else
      render json: supp.errors
    end
  end

  def update
    @supplier = Supplier.find_by(id: params[:id])

    @supplier.update(name: params[:name] || supp.name, 
    email: params[:email] || supp.email, 
    phone_number: params[:phone_number] || supp.phone_number)

    render :show
  end

  def destroy
    status = false
    supp = Supplier.find_by(id: params[:id])
    supp.destroy
    
    if Supplier.find_by(id: params[:id]) == nil
      status = true
    end
    render json: {id_selected: params[:id], removed_successfully: status}
  end

end
