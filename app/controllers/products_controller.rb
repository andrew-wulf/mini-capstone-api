class ProductsController < ApplicationController
  def index
    @products = Product.all
    render(template: "products/index", formats: :json)
  end

  def show
    @product = Product.find_by(id: params[:id])
    render(template: "products/show", formats: :json)
  end

  def show_category
    @products = Product.find_by(category: params[:category])
    render(template: "products/category", formats: :json)
  end

  def create
    
    prod = Product.new(name: params[:name], price: params[:price], category: params[:deps], on_sale: params[:sale], image_url: params[:url], in_stock: params[:stock], description: params[:desc])

    prod.save
    @product = Product.last
    
    render(template: "products/show", formats: :json)
  end

  def update
    prod = Product.find_by(id: params[:id])

    prod.name = params[:name], prod.price = params[:price], prod.category = params[:deps], prod.on_sale = params[:sale], prod.image_url = params[:url], prod.in_stock = params[:stock], prod.description = params[:desc]
    prod.save
    render(template: "products/show", formats: :json)
  end

  def destroy
    status = false
    prod = Product.find_by(id: params[:id])
    prod.destroy
    
    if Product.find_by(id: params[:id]) == nil
      status = true
    end
    render json: {id_selected: params[:id], removed_successfully: status}
  end
end
