# Usine

Usine (french word for factory) is a small gem aiming to bring a limited feature set of factory_girl
when using Trailblazer’s operations. [Trailblazer](http://trailblazer.to/) advocates against using factory_girl to avoid
differences when initializing objects. Usine follows this path but allows you to define defaults for the
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

### Definitions

Definitions are the base of anything in Usine, they are used in factories to generate
the hash of params sent to the operation.

```ruby
Usine.definition(:item) do
  title { "Some title" }
end

Usine.definition(:user) do
  email { "j.jaffeux@example.com" }
end
```

### Factories

Factories let you build a hash which will be sent to an operation when you need it.
This is what you will call when building your objects in a test.

```ruby
Usine.factory(Item::Create) do
  item # if not block given, it will invoke use(:item), which means it will use the :item Definition
  current_user use(:user)
end
```

### Invoking factories

Usine respects Trailblazer naming differences when creating an operation : call, run and present.
Which means you have 3 different ways to invoke a factory :

```ruby
Usine.(Item::Create, item: {title: "different title"})
Usine.run(Item::Create, item: {title: "different title"})
Usine.present(Item::Create, item: {title: "different title"})
```

`present` for example can be used to access model/contract without calling process in the operation.

Let see an example in a test :
```
let(:user_id) {
  Usine.(User::Create).model.id
}
```

### Sequences

Sequences are used in Definitions to help you create different occurences of the same kind of attribute.

```ruby
# global sequence
Usine.sequence(:title) do |n|
  "title number #{n}"
end

# inline sequence in a definition
Usine.definition(:user) do
  sequence(:email) { |n| "joffrey_#{n}@example.com" }
  email # if no block given, Usine will try to invoke generate(:email)
  title # and will also search in global sequences
  alt_email { generate(:email) }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jjaffeux/usine. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
