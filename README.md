# Active Admin Sortable

This gem extends ActiveAdmin so that your index page's table rows can be sortable via a drag-and-drop interface.

## Description

Unlike the original gem, `sortable` handler in your resource
```ruby
ActiveAdmin.register Page do
  # ...
  sortable
  # ...
end
```

will create collection action, which accepts POST parameters like `page[]=1&page[]=2...page[]=N`
```ruby
collection_action :reorder, :method => :post do
  # 1. parse nested query into array
  # 2. array keys - positions, array values - IDs
  # 3. simple query like 'UPDATE pages SET position = #{position} WHERE id = #{id}'
end
```

NOTE: Works for one default namespace (`config.default_namespace = :admin`)

## Prerequisites

This extension assumes that you're using one of the following on any model you want to be sortable.

## Requirements

### 1. [acts_as_list](https://github.com/swanandp/acts_as_list)

#### 1.1. Install gem
```ruby
gem 'acts_as_list'
```

#### 1.2. Create migration
```ruby
rails g migration AddPositionToPages position:integer
```

```ruby
class AddPositionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :position, :integer
    add_index :pages, :position
  end
end
```

#### 1.3. Execute migration
```ruby
rake db:migrate
```

#### 1.4. Change your model
```ruby
class Page < ActiveRecord::Base
  # ...
  acts_as_list
  default_scope { order('position ASC') } # optional
  # ...
end
```

### 2. [js-routes](https://github.com/railsware/js-routes)

#### 2.1. Install gem
```ruby
gem 'js-routes'
```

#### 2.2. Require JS route

##### CoffeeScript

```coffee
#= require js-routes
```

##### JavaScript

```js
//= require js-routes
```

#### 2.3. Clear cache (urgent!)
```ruby
rake tmp:cache:clear
```

## Usage

### Add it to your Gemfile

```ruby
gem 'activeadmin-sortable', github: 'https://github.com/xcopy/activeadmin-sortable.git'
```

### Include the JavaScript

#### CoffeeScript

```coffee
#= require active_admin/sortable
```

#### JavaScript

```javascript
//= require active_admin/sortable
```

### Include the stylesheet

#### SASS

```sass
@import "active_admin/sortable";
```

#### CSS

```css
//= require active_admin/sortable
```

### Configure your ActiveAdmin Resource
```ruby
ActiveAdmin.register Page do
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable # creates the controller action which handles the sorting

  index do
    sortable_handle_column # inserts a drag handle
    # other columns...
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
