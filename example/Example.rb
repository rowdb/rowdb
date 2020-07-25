#!/usr/bin/env ruby
# encoding: utf-8

#require 'rowdb'
require_relative '../lib/rowdb.rb'

db = Rowdb.new(:file_system, 'db.json')

db.defaults({ checklist: [] })
