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
  end
end
