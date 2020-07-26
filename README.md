<p align="center">

  <img src="./Assets/Logo.svg" raw=true width="500" style="margin-left: auto; margin-right: auto;"/>

</p>
<p align="center">

  <a href="https://www.mozilla.org/MPL/2.0/" alt="MPLv2 License">
    <img src="https://img.shields.io/badge/license-MPLv2-blue.svg" />
  </a>

</p>

A JSON database for Ruby inspired by [lowdb](https://github.com/typicode/lowdb).

## Usage

Load the database:
```ruby
db = Rowdb.new(:file_system, 'db.json')
```

Create a default structure:
```ruby
db.defaults({ items: [] })
```

## Installation

In your Gemfile add:
```ruby
gem "rowdb"
```  

Then run:
```
bundle install
```

Or:
```
gem install rowdb
```

## Why?

I needed to store data for [Reflekt](https://github.com/maedi/reflekt) in the file system.

## API

### new()

```ruby
Rowdb.new(adapter = :file_system, file_name)
```

**Params:**
* `adapter` - The method to read and write data. Defaults to the file system.
* `file_name` - The path to the file. Accepts path relative to application root or absolute path.

**Returns:** `Rowdb` - A database to interact with.
