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
      if prod.valid?
        prod.save

        @data = prod.display
        render(template: "products/show", formats: :json)
      else
        render json: prod.errors
      end
    else
      render json: {message: 'No item exists at this index.'}
    end
  end

  def show_category
    @products = Product.find_by(category: params[:category])
    render(template: "products/category", formats: :json)
  end

  def create
    prod = Product.new(name: params[:name], color: params[:color], price: params[:price], categories: params[:categories], on_sale: params[:on_sale] || 0, in_stock: params[:in_stock] || 0, description: params[:description], material: params[:material], weight: params[:weight], country_of_origin: params[:country_of_origin], supplier_id: params[:supplier_id])

    display(prod)
  end

  def update
    prod = Product.find_by(id: params[:id])

    prod.update(name: params[:name] || prod.name, price: params[:price] || prod.price, categories: params[:categories] || prod.categories, on_sale: params[:on_sale] || prod.on_sale, in_stock: params[:in_stock] || prod.in_stock, description: params[:description] || prod.description,
    color: params[:color] || prod.color, weight: params[:weight] || prod.weight, material: params[:material] || prod.material, country_of_origin: params[:country_of_origin] || prod.country_of_origin, supplier_id: params[:supplier_id] || prod.supplier_id)
    
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




end
