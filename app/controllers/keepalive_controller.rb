# encoding: UTF-8
# ===========================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
# ===========================================================================
# System info controller.
#
class KeepaliveController < ApplicationController
  def keepalive
    render text: 'OK'
  end
end
