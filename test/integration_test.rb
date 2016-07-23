require 'test_helper'

describe "IntegrationTest" do
  it "supports kitchen sink example" do
    Usine.sequence(:email) do |n|
      "example#{n}@example.com"
    end

    Usine.definition(:item) do
      title { "SOME TITLE" }
      type { "1" }
    end

    Usine.definition(:user) do
      sequence(:tag, 'a') {|n| "tag_#{n}"}
      email
      name { "John" }
      tags { [generate(:tag), generate(:tag)] }
    end

    Usine.factory(Item::Create) do
      item
      current_user { use(:user) }
    end

    operation = Usine.(Item::Create, item: {type: "2" }, current_user: {name: "Maria"})

    model = operation.model
    current_user = model.current_user

    model.title.must_equal("SOME TITLE")
    model.type.must_equal("2")
    current_user.name.must_equal("Maria")
    current_user.email.must_equal("example1@example.com")
    current_user.tags.must_equal(["tag_a", "tag_b"])
  end
end
