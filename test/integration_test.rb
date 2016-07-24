require 'test_helper'

describe "IntegrationTest" do
  before do
    Usine.operations = []
  end

  it "searchs for an existing facotry" do
    Usine.operation(Item::Create) do
      item
      current_user User::Create
    end

    operation = Usine.(Item::Create)
    model = operation.model

    model.title.must_equal("DEFAULT TITLE")
  end

  it "supports sequences" do
    Usine.operation(Item::Create) do
      item :book
      current_user User::Create
    end

    operation = Usine.(Item::Create)
    model = operation.model

    model.title.wont_be_same_as(model.subtitle)
  end

  it "supports overriding attribtues" do
    Usine.operation(Item::Create) do
      item :book
      current_user User::Create
    end

    operation = Usine.(Item::Create, item: {subtitle: "MY TITLE"})
    model = operation.model

    model.subtitle.must_equal("MY TITLE")
  end

  it "supports overriding an operation used as a factory" do
    Usine.operation(Item::Create) do
      item
      current_user User::Create
    end

    res, operation = Usine.run(Item::Create, current_user: {email: "jojo@caramail.com"})

    res.must_equal(true)
  end
end
