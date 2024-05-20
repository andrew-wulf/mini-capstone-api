class ProductsController < ApplicationController
  def index
    @products = Product.all
    render(template: "products/index", formats: :json)
  end

  def show
    prod = Product.find_by(id: params[:id])
    display(prod)
  end

  def display(prod)
    if prod
      @data = prod.display
      render(template: "products/show", formats: :json)
    else
      render json: {message: 'No item exists at this index.'}
    end
  end

  def show_category
    @products = Product.find_by(category: params[:category])
    render(template: "products/category", formats: :json)
  end

  def create
    prod = Product.new(name: params[:name], price: params[:price], category: params[:deps], on_sale: params[:on_sale] || 0, image_url: params[:url], in_stock: params[:in_stock] || 0, description: params[:desc])

    if prod.valid?
      prod.save
      display(prod)
    else
      render json: prod.errors
    end
  end

  def update
    prod = Product.find_by(id: params[:id])

    prod.update(name: params[:name] || prod.name, price: params[:price] || prod.price, category: params[:deps] || prod.category, on_sale: params[:sale] || prod.on_sale, image_url: params[:url] || prod.image_url, in_stock: params[:stock] || prod.in_stock, description: params[:desc] || prod.description)
  
    display(prod)
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


  def test
    render(template: 'products/test', formats: :json)
  end


end
