class Product < ActiveRecord::Base
  def self.find_products_for_sale
    find(:all, :order => 'title')
  end
    
  # validations
  validates_presence_of :title, :description, :image_url
  validates_uniqueness_of :title
  validates_numericality_of :price
  validates_format_of :image_url, :with => /\.{gif|jpg|png}/i, :message => 'must be url of image GIF, JPG, or PNG'

  protected
  def validate
    min = 0.01
    errors.add(:price, "must be #{min} at minimum") if price.nil? || price < min
  end
end
