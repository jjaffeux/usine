require 'test_helper'

describe "IntegrationTest" do
  before do
    Usine.operations = []
  end

  it "supports sequences" do
    Usine.operation(Item::Create) do
      item :book
    end

    operation = Usine.(Item::Create)
    model = operation.model

    model.title.wont_be_same_as(model.subtitle)
  end

  it "supports overriding attribtues" do
    Usine.operation(Item::Create) do
      item :book
    end

    operation = Usine.(Item::Create, item: {subtitle: "MY TITLE"})
    model = operation.model

    model.subtitle.must_equal("MY TITLE")
  end
end
