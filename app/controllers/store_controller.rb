class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      msg = "no such a product: #{params[:id]}"
      logger.error(msg)
      flash[:notice] = msg
      redirect_to :action => :index
    else
      @cart = find_cart
      @cart.add_product(product)
    end
  end
  
  private
  def find_cart
    session[:cart] ||= Cart.new
  end

end
