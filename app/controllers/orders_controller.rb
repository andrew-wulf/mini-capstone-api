class OrdersController < ApplicationController

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
      render :index
    else
      render json: {}, status: :unauthorized
    end
  end

  def show
    if current_user
      @order = Order.find_by(id: params[:id])
      if @order.user_id == current_user.id
        render :show
      else
        render json: {Denied: "Order doesn't belong to this user."}
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def create
    if current_user
      prod = Product.find_by(id: params[:product_id])
      if prod
        if prod.valid?
          qty = params[:quantity].to_i

          @order = Order.new(user_id: current_user.id, product_id: params[:product_id], 
          quantity: qty, 
          subtotal: prod.get_price * qty,
          tax: prod.tax * qty, 
          total: prod.total * qty)

          if @order.valid?
            @order.save
            render :show
          else
            render json: @order.errors
          end
        else
          render json: prod.errors
        end
      else
        render json: {message: 'No item exists at this index.'}
      end
    else
      render json: {}, status: :unauthorized
    end

  end

end
