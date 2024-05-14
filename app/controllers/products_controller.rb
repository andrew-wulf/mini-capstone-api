class ProductsController < ApplicationController
  def index
    @products = Product.all
    render(template: "products/index", formats: :json)
  end

  def show
    @products = Product.all
    render(template: "products/show", formats: :json)
  end

  def dynamic
    id = params[:id]
    @product = Product.find(id)
    render(template: "products/dynamic", formats: :json)
  end
end
