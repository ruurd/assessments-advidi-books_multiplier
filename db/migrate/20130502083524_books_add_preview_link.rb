# encoding: UTF-8
# ===========================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
# ===========================================================================
#
class BooksAddPreviewLink < ActiveRecord::Migration
  def change
    add_column :books, :preview, :string, limit: 200, null: true, default: nil
  end
end
