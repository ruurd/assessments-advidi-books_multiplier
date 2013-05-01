class CreateBooks < ActiveRecord::Migration
	def change
		create_table :books do |t|
			t.string :isbn, limit: 30, null: true, default: nil
			t.string :author, limit: 200, null: true, default: nil
			t.string :title, limit: 200, null: true, default: nil
			t.string :thumbnail, limit: 200, null: true, default: nil
		end
	end
end
