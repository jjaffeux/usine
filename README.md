# Usine

Usine (french word for factory) is a small gem aiming to bring a limited feature set of factory_girl
when using Trailblazer’s operations. [Trailblazer](http://trailblazer.to/) advocates against using factory_girl to avoid
difference when initializing objects. Usine follows this path but allows you to define defaults for the
parameters passed to your operations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'usine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install usine

## Usage

### Create definitions to be used by factories

```ruby
Usine.define(Item::Create) do
  title { "Some title" }
end
```

Define accepts unlimited args after the operation class, to allow you to share
definitions.

```ruby
SendableDefinition = proc {
  sendable { false }
}

Usine.define(Item::Create, SendableDefinition) do
  title { "Some title" }
end

Usine.define(Item::Update, SendableDefinition) do
  title { "Some title" }
end
```

### Using factories

Usine respects Trailblazer naming differences when creating an operation : call, run and present.

```ruby
Usine.(Item::Create, title: "different title")
Usine.call(Item::Create, title: "different title")
Usine.run(Item::Create, title: "different title")
Usine.present(Item::Create, title: "different title")
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jjaffeux/usine. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
