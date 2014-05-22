class ItemsController < ApplicationController

	def new
		@item = Item.new
	end

	def show
		@item = Item.find(params[:id])
		response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
		#debugger
		@images = response["results"]
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
