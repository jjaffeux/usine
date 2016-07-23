require 'test_helper'

describe "FactoryTest" do
  subject { Usine::Factory.new(Item::Create, {test: 1}) { "bar" } }

  it "#operation" do
    subject.operation.must_equal(Item::Create)
  end

  it "#attributes" do
    subject.attributes.must_equal(test: 1)
  end

  it "#block" do
    subject.block.call.must_equal("bar")
  end
end
