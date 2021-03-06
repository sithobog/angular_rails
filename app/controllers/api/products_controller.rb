class Api::ProductsController < Api::ApplicationController
	respond_to :json
  def index
    respond_to do |format|
      format.json { render json: Product.all }
      format.html
    end
  end

  def create
    respond_with Product.create(product_params)
  end

  def destroy
    respond_with Product.destroy(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    respond_with @product.update_attributes(product_params)
  end

  def show
    respond_with Product.find(params[:id])
  end

private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
