class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
    render(template: "suppliers/index", formats: :json)
  end

  def show
    supp = Supplier.find_by(id: params[:id])
    display(supp)
  end

  def display(supp)
    if supp
      if supp.valid?
        supp.save

        @data = supp.attributes
        render(template: "suppliers/show", formats: :json)
      else
        render json: supp.errors
      end
    else
      render json: {message: 'No item exists at this index.'}
    end
  end


  def create
    supp = Supplier.new(name: params[:name], 
    email: params[:email], 
    phone_number: params[:phone_number])

    display(supp)
  end

  def update
    supp = Supplier.find_by(id: params[:id])

    supp.update(name: params[:name] || supp.name, 
    email: params[:email] || supp.email, 
    phone_number: params[:phone_number] || supp.phone_number)

    display(supp)
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
