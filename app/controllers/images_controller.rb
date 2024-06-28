class ImagesController < ApplicationController

  def index
    @images = Image.all
    render :index
  end

  def show
    @image = Image.find_by(id: params[:id])
    if @image
      render :show
    else
      render json: {message: 'No item exists at this index.'}
    end
  end

  def create
    @image = Image.new(name: params[:name], 
    email: params[:email], 
    phone_number: params[:phone_number])

    if @image.save
      render :show
    else
      render json: @image.errors
    end
  end

  def update
    @image = Image.find_by(id: params[:id])

    @image.update(url: params[:url] || @image.url, 
    product_id: params[:product_id] || @image.product_id)

    render :show
  end

  def destroy
    status = false
    img = Image.find_by(id: params[:id])
    img.destroy
    
    if Image.find_by(id: params[:id]) == nil
      status = true
    end
    render json: {id_selected: params[:id], removed_successfully: status}
  end
end
