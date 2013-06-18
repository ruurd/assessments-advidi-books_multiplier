# encoding: UTF-8
# ============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
# ============================================================================
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
rfp = User.create(email: 'rfpels@gmail.com',
                  first_name: 'Ruurd',
                  last_name: 'Pels',
                  gender: 'm',
                  phone: '+31222315034',
                  mobile: '+31612914545',
                  is_admin: 1)
rfp.save

