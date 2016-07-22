require 'test_helper'

describe "FactoryTest" do
  let(:definition) {
    Usine::Definition.new(Item::Create) do
      title    { "DEFAULT_TITLE" }
      subtitle { "DEFAULT_SUBTITLE" }
    end
  }

  subject { Usine::Factory.new(:run, Item::Create, title: "ALT_TITLE", definitions: [definition]) }

  it "#mode" do
    subject.mode.must_equal(:run)
  end

  it "#operation" do
    subject.operation.must_equal(Item::Create)
  end

  it "#attributes" do
    subject.attributes.must_equal(title: "ALT_TITLE")
  end

  it "#merged_attributes" do
    subject.merged_attributes[:title].must_equal("ALT_TITLE")
  end
end
