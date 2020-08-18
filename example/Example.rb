#!/usr/bin/env ruby
# encoding: utf-8

# This example accesses library directly. Instead your app should use:
#   require 'rowdb'
require_relative '../lib/rowdb.rb'

# Call from project root with command:
#   ./example/Example.rb

# Load the database.
db = Rowdb.new('example/db.json')

# Set a default structure.
db.defaults({ 'checklist' => [] })

# Set data.
db.set('checklist[0]', 'milk')
  .set('checklist[1]', 'cheese')
  .set('checklist[2]', 'eggs')
  .write()

# Push data.
db.get('checklist')
  .push('spam')
  .write()

# Get data.
data = db.get('checklist').value()
p data
