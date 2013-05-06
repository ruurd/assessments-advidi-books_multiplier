# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#----------------------------------------------------------------------------
# System info controller.
#
class SysinfoController < ApplicationController
  before_filter :authenticate_admin!

  def index
    begin
      @git_version = ::File.read('./REVISION').chomp
    ensure
      @git_version ||= 'Unknown (REVISION file is missing)'
    end
  end
end
