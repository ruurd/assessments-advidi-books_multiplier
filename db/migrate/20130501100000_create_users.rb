# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================
class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :first_name, limit: 50, null: true, :default => nil
			t.string :last_name, limit: 50, null: true, :default => nil
			t.string :gender, limit: 20, null: true, :default => nil
			t.string :phone, limit: 15, null: true, :default => nil
			t.string :mobile, limit: 15, null: true, :default => nil
			t.string :im, limit: 50, null: true, :default => nil
		end
	end
end
