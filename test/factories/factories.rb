# encoding: UTF-8
# ============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
# ============================================================================
FactoryGirl.define do
  sequence :number do |n|
    "#{n}"
  end

  factory :book do
    google_books_id { 'ABCDEF' }
    isbn_13 { 'xxx1212121212' }
    author { 'schrijver' }
    title { 'Boek' }
  end
end
