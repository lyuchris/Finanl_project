class Admin::ProductsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin
	before_action :find_product, only:[:show,:edit, :update, :destroy]
	layout "admin"

	def index 
		@products = Product.all

	end

	def show 

	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)	

		if @product.save
			
			respond_to do |format|
				  format.html { redirect_to admin_product_path(@product)}
		
			end		
		else 
			render :new
		end
	end

	def edit 
	end

	def update
		if @product.update(product_params)		
			
			respond_to do |format|
				  format.html { redirect_to admin_product_path(@product)}
	
			end		
		else 
			render :edit
		end
	end


	def destroy 
		@product.destroy
		redirect_to admin_products_path
	end




	protected 
	def check_admin 
		unless current_user.role == "admin"
			raise ActiveRecord::RecordNotFound			
		end
	end
	def find_product
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:name,:progress,:description,:rule ,:min_amount,:cost,:cost_detail,:people,:lucky_number,:donation_file ,:npo_id)
	end


end