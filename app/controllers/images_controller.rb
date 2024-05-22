class ImagesController < ApplicationController
  def index
    @images = Image.all
    render(template: "images/index", formats: :json)
  end

  def show
    img = Image.find_by(id: params[:id])
    display(img)
  end

  def display(img)
    if img 
      if img.valid?
        img.save

        @data = img.attributes
        render(template: "images/show", formats: :json)
      else
        render json: img.errors
      end
    else
      render json: {message: 'No item exists at this index.'}
    end
  end


  def create
    img = Image.new(name: params[:name], 
    email: params[:email], 
    phone_number: params[:phone_number])

    display(img)
  end

  def update
    img = Image.find_by(id: params[:id])

    img.update(url: params[:url] || img.url, 
    product_id: params[:product_id] || img.product_id)

    display(img)
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
