class CreateBooks < ActiveRecord::Migration
	def change
		create_table :books do |t|
			t.string :google_books_id, limit: 30, null: false, default: nil
			t.string :isbn_13, limit: 30, null: true, default: nil
			t.string :author, limit: 200, null: true, default: nil
			t.string :title, limit: 200, null: true, default: nil
			t.string :thumbnail, limit: 200, null: true, default: nil
		end

		add_index :books, :google_books_id,  {name: "books_google_books_id_uq", unique: true}
	end
end
