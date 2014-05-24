class ItemsController < ApplicationController

	def new
		@item = Item.new
	end

	def show
		@item = Item.find(params[:id])
    #debugger
    response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
    @images = response["results"]
    second_response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key}")
    if second_response["results"][0]["price"]
    	@price = second_response["results"][0]["price"]
    else
    	"The price of this item is not available without selecting additional options (such as desired weight, quantity, etc). "
    end
    third_response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key}")
    if third_response["results"][0]["materials"]
    	@materials = third_response["results"][0]["materials"]
    end
    forth_response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key}")
    @description = forth_response["results"][0]["description"]
	end

	

	def create
		@item = Item.new(item_params)
		if @item.save
			redirect_to wishlist_path(params[:wishlist_id]), notice: "Item added."
		else
			redirect_to :back, alert: "Failed to save."
		end
	end

	private

	def item_params
		params.require(:item).permit!
	end
end
