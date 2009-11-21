class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    @cart = find_cart
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      msg = "no such a product: #{params[:id]}"
      logger.error(msg)
      redirect_to_index msg
    else
      @cart = find_cart
      @current_item = @cart.add_product(product)
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index 'cart is empty now'
  end
  
  private
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => :index
  end

end
