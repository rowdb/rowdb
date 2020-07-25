#!/usr/bin/env ruby
# encoding: utf-8

#require 'rowdb'
require_relative '../lib/rowdb.rb'

db = Rowdb.new(:file_system, 'example/db.json')

db.defaults({ checklist: [] })

db.set('checklist[0]', 'milk')
