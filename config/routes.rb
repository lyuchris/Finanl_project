Rails.application.routes.draw do
 
  devise_for :users
	resources :products, only:[:index,:show] do #前台只能看index和show頁面
		resources :donations, only:[:show,:new,:create], :controller =>"product_donations"
	end
	root "products#index" 

	namespace :admin do
  	resources :products  #後台CRUD都可
  	resources :npos 
  	resources :users
	end

	 #API routes path
  namespace :api, defaults:{ format: :json }do
    namespace :v1 do
      #devise_for :users
      resources :users, :only => [:show, :create, :update, :destroy]
    end
  end 

end
