# encoding: UTF-8
# ============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
# ============================================================================
#
require 'test_helper'

class BookTest < ActiveSupport::TestCase

  context 'A book' do
    setup do
      @book = FactoryGirl.create(:book,
                                 google_books_id: '123212321',
                                 isbn_13: '1234567890123',
                                 author: 'W. Riter',
                                 title: 'One fine book this is!',
                                 thumbnail: nil,
                                 preview: nil)
    end

    should 'be valid' do
      assert @book
    end

    should 'be able to save' do
      assert @book.save
    end

    should 'be unable to save a duplicate' do
      bookcount = Book.where(google_books_id: '123212321').count
      anotherbook = FactoryGirl.build(:book,
                                      google_books_id: '123212321',
                                      isbn_13: '3210987654321',
                                      author: 'R. Eader',
                                      title: 'I finished it in one sitting!',
                                      thumbnail: nil,
                                      preview: nil)
      assert_raise ActiveRecord::RecordNotUnique do
        anotherbook.save
      end

      assert_equal bookcount, Book.where(google_books_id: '123212321').count
    end

    should 'be able to added' do
      bookcount = Book.all.count
      @book2 = FactoryGirl.create(:book,
                                  google_books_id: '123212322',
                                  isbn_13: '3210987654321',
                                  author: 'R. Eader',
                                  title: 'I finished it in one sitting!',
                                  thumbnail: nil,
                                  preview: nil)
      assert_equal bookcount + 1, Book.all.count
    end

  end
end
