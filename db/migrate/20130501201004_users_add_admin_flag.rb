# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================

class UsersAddAdminFlag < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false, after: :im
  end
end
