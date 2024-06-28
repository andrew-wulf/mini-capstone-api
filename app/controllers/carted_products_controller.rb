class CartedProductsController < ApplicationController
  before_action :authenticate_user

  def create

    cp = CartedProduct.find_by(user_id: current_user.id, product_id: params[:product_id], status: 'carted')
    if cp
      @entry = cp
      @entry.update(quantity: cp.quantity + 1)
    else
      @entry = CartedProduct.new(user_id: current_user.id, product_id: params[:product_id], quantity: params[:quantity], status: 'carted',  order_id: params[:order_id])
    end

    if @entry.save
      @carted_product = @entry
      render :show
    else
      render json: {errors: @entry.errors}
    end
  end


  def update
    @entry = CartedProduct.find_by(id: params[:id])
    @entry.update(status: params[:status] || @entry.status, quantity: params[:quantity] || @entry.quantity)
    
    @carted_product = @entry
    render :show
  end

  def remove
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.remove

    render :show
  end

  def checkout
    if current_user.checkout
      render json: {status: 'Success!'}
    else
      render json: {status: 'Error'}
    end
  end

end
