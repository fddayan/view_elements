# ViewElements

View partials structured as components inspired by all JavaScript frameworks out there (Angular2, Marko.js, Vue.js, React).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'view_elements'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install view_elements

## Intro

The whole purpose of this project is trying to fix the partial and helper madness. That is, one view folder having dozen of partials, other views from different controllers using partials from other views in a not so good predictable way, and helper methods as global methods everywhere.

Also, each component can take care of loading the data/models that needs, removing the need for the controller to load the models. I never liked the controller loading models. I started noticing that every time I wanted to reuse a partial, I had to make sure I loaded the data it needs on the controller and that was creating a lot of duplication. I know it breaks the MVC paradigm, but I find it much easier loading that in the component.

The idea is that each `partial` now becomes a `component` and stylesheet, Javascript, presenter and view goes into the same folder named as the partial.

Also, component can have nested components, so it can be structured in a predictable way and the layout itself can be used for documenting how the partial works.

## Usage

Run generator

`rails generate view_elements:component shopping_cart/items_list`

It will create this structure

```
/app
  /view_elements
    /shopping_cart
      /items_list
        /item
          index.html.erb
          presenter.rb
          component.js
          style.scss  
        index.html.erb
        presenter.rb
        component.js
        style.scss        
```

**In your existing view `app/views/cart/index.html.erb`**

```erb
<%= cmp 'shopping_cart/items_list', items: @items %>
```

**Inside folder `app/view_elements/shopping_cart/items_list`**

index.html.erb

```erb
  <%= presenter.title %>
  <ul class='item-list'>
    <% items.each do |item| %>
      <li class='item'><%= componet.cmp 'item', item: item %></li>
      <!--component.cmp looks for components in the current component directory -->
    <% end %>
  </ul>
```

presenter.rb

```ruby
module ShoppingCart::ItemsList
  class Presenter < ViewElements::Presenter
    properties :items

    def title
      "Your cart with #{items.size}"
    end
  end
end
```

component.js

```javascript
  $('.item-list li').on('click', function() {
    alert('Item clicked');
  });
```

style.scss

```scss
.item-list {
  li {
    background-color: silver;
  }
}
```

**Inside folder `app/view_elements/shopping_cart/items_list/item`**

index.html.erb

```erb
  <div class='item'>
    <b><%= item %></b>
    <%= presenter.link_to_remove %>
  </div>
```

presenter.rb

```ruby
module ShoppingCart::ItemsList::Item
  class Presenter < ViewElements::Presenter
    properties :item

    def link_to_remove
      h.link_to 'Remove', item_path(item), method: :destroy
    end
  end
end
```

component.js

```javascript
  // Do something fancy with Javascript
```

style.scss

```scss
.item {
  text-decoration: underline;
}
```

**Assets**

You have to add the following to your `application.js.erb` and `application.scss.erb` in order to have `component.js` and `style.scss` available. Both need to end with the `.erb` extension.

application.scss.erb

```erb
<% ViewElements::Assets.css_files.each do |f| %>
  @import '<%=f %>';
<% end %>
```

application.js.erb

```erb
<% ViewElements::Assets.js_files.each do |f| %>
  <%= require_asset f %>
<% end %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/view_elements.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
