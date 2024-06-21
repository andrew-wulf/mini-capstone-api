class ProductsController < ApplicationController
  before_action :check_admin, only: [:create, :update, :destroy]

  def index
    if params[:limit] == nil || params[:offset] == nil
      @products = Product.all
    
    else
      @products = Product.offset(params[:offset]).limit(params[:limit])
    end
    render(template: "products/index", formats: :json)
  end

  def show
    @product = Product.find_by(id: params[:id])

    if @product
      render :show
    else
      render json: {message: 'No item exists at this index.'}
    end
  end


  def create
    @product = Product.new(name: params[:name], color: params[:color], price: params[:price], categories: params[:categories], on_sale: params[:on_sale] || 0, in_stock: params[:in_stock] || 0, description: params[:description], material: params[:material], weight: params[:weight], country_of_origin: params[:country_of_origin], supplier_id: params[:supplier_id])

    if @product.save
      render :show
    else
      render json: prod.errors
    end
  end

  def update
    @product = Product.find_by(id: params[:id])

    prod.update(name: params[:name] || prod.name, price: params[:price] || prod.price, categories: params[:categories] || prod.categories, on_sale: params[:on_sale] || prod.on_sale, in_stock: params[:in_stock] || prod.in_stock, description: params[:description] || prod.description,
    color: params[:color] || prod.color, weight: params[:weight] || prod.weight, material: params[:material] || prod.material, country_of_origin: params[:country_of_origin] || prod.country_of_origin, supplier_id: params[:supplier_id] || prod.supplier_id)
    
    if @product.save
      render :show
    else
      render json: prod.errors
    end
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


  def search
    if params[:limit] == nil
      @products = Product.where("LOWER( name ) LIKE ?", "%" + params[:q] + "%")
    else
      @products = Product.where("LOWER( name ) LIKE ?", "%" + params[:q] + "%").limit(params[:limit])
    end
    
    render(template: "products/index", formats: :json)
  end

end
