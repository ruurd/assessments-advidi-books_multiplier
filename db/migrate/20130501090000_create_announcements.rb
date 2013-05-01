# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================
class CreateAnnouncements < ActiveRecord::Migration
	def change
		create_table :announcements do |t|
			t.string :locale, limit: 2, null: false, default: 'en'
			t.string :level, limit: 10, null: false, default: 'info'
			t.datetime :starts_at
			t.datetime :ends_before
			t.text :message

			t.timestamps
		end
	end
end