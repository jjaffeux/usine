# Usine

Usine (french word for factory) is a wrapper around factory_girls with two goals: simplify using [Trailblazer](http://trailblazer.to/) with factory_girl, and avoid initializing models through factory_girl instead of Trailblazer.

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

Usine let you reuse your factories and use them to define the params sent to your Operation.

```ruby
FactoryGirl.define do
  factory :item do
    title { "Default title"}
  end

  factory :user do
    email { "xx@exxample.com"}
  end
end

# If no symbol given, Usine will try to find an existing factory with this name
Usine.operation(Item::Create) do
  item
  current_user :user
end

# Usine will transmit [call, run, present] to the operation invocation
# so you can have the kind of operation you want in your test
# for example `present` will not run process in your Operation
Usine.(Item::Create, item: {title: "Another title"})
Usine.call(Item::Create, item: {title: "Another title"})
Usine.run(Item::Create, item: {title: "Another title"})
Usine.present(Item::Create, item: {title: "Another title"})
```

### Model less factories

If your params are not related to a model you can simply create a factory this way:
```ruby
FactoryGirl.define do
  factory :search, class:Usine::NullModel do
    query { "*"}
  end
end
```

### Factory girl features

All factory_girl features should work, sequences for example are working:

```ruby
FactoryGirl.define do
  sequence(:email) do |n|
    "some_email_#{n}@example.com"
  end

  factory :user do
    contact { generate(:email) }
  end
end
```

### Writing a test with Usine

```ruby
# Without Usine
let(:item) {
  Item::Create.({
    item: {
      title: "DEFAULT_TITLE"
    },
    current_user: User::Create.(email: "some_email@example.com").model
  }).model
}

# With Usine
FactoryGirl.define do
  factory :item do
    title { "DEFAULT_TITLE" }
  end

  factory :user do
    email { "some_email@example.com" }
  end
end

Usine.operation(Item::Create) do
  item
  current_user :user
end

let(:item) { Usine.(Item::Create).model }
```

The second example might look more verbose, but you only have to define factories/operations one time.
And then you can reuse it for all your tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jjaffeux/usine. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
