#!/usr/bin/env ruby
# encoding: utf-8

# Access library directly. In your app use:
#   require 'rowdb'
require_relative '../lib/rowdb.rb'

# Call from project root with command:
#   ./example/Example.rb
db = Rowdb.new(:file_system, 'example/db.json')

# Set a default structure.
db.defaults({ 'checklist' => [] })

# Add data.
db.set('checklist[0]', 'milk')
db.set('checklist[1]', 'cheese')
db.set('checklist[2]', 'eggs')

# Get data.
data = db.get('checklist')
p data
