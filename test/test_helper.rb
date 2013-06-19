# encoding: UTF-8
# ============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
# ============================================================================
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl'
require 'rails/test_help'

# Add factories to rails root
Dir[Rails.root.join("test/factories/**/*.rb")].each {|f| require f}

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
