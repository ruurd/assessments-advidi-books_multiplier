#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

BooksMultiplier::Application.routes.draw do

	get 'change_locale', to: 'application#change_locale'

	scope "(:locale)" do
		devise_for :users
		devise_scope :user do
			get "sign_out", :to => 'devise/sessions#destroy'
		end
		get "sign_in", :to => 'devise/sessions#new'

		get "about", :to => 'about#index'
		get "sysinfo", :to => 'sysinfo#index'

		resources :announcements
		resources :books do
			collection do
				get :load_all
			end
		end
		resources :users
	end

	root :to => "welcome#index"

	get "books/v1/volumes", :to => "books#load", :defaults => { :format => 'json' }

	constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.admin? }
	constraints constraint do
		mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
	end
end
