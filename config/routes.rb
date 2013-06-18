# encoding: UTF-8
# ===========================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
# ===========================================================================

BooksMultiplier::Application.routes.draw do

  get 'change_locale', to: 'application#change_locale'

  scope '(:locale)' do
    get 'about', to: 'about#index'
    get 'sysinfo', to: 'sysinfo#index'

    resources :books do
      collection do
        get :load_all
        get :come_back_later
      end
    end
  end

  root to: 'welcome#index'

  get 'books/v1/volumes', to: 'books#load', defaults: { format: 'json' }
end
