require 'test_helper'

describe "IntegrationTest" do
  it "overwrites default attribute" do
    definition = Usine::Definition.new(Item::Create) do
      title { "DEFAULT_TITLE" }
    end
    factory = Usine::Factory.new(:run, Item::Create, title: "ALT_TITLE", definitions: [definition])

    attributes = factory.merged_attributes

    attributes[:title].must_equal("ALT_TITLE")
  end

  it "uses global sequences" do
    Usine.sequence(:title) do |n|
      "title number #{n}"
    end

    definition = Usine::Definition.new(Item::Create) do
      title
      subtitle { generate(:title) }
    end
    factory = Usine::Factory.new(:run, Item::Create, definitions: [definition])

    attributes = factory.merged_attributes

    attributes[:title].must_equal("title number 1")
    attributes[:subtitle].must_equal("title number 2")
  end

  it "uses inline sequences" do
    Usine.sequence(:title) do |n|
      "title number #{n}"
    end

    definition = Usine::Definition.new(Item::Create) do
      sequence(:title) { |n| "title number #{n}" }
      title { generate(:title) }
    end
    factory = Usine::Factory.new(:run, Item::Create, definitions: [definition])

    attributes = factory.merged_attributes

    attributes[:title].must_equal("title number 1")
  end

  it "uses global definitions" do
    Usine.definition(Item::Create) do
      title { "SOME TITLE" }
    end

    factory = Usine::Factory.new(:run, Item::Create)

    attributes = factory.merged_attributes

    attributes[:title].must_equal("SOME TITLE")
  end
end
