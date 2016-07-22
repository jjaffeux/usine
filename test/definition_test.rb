require 'test_helper'

describe "DefinitionTest" do
  subject { Usine::Definition.new("foo") { "bar" } }

  it "#name" do
    subject.name.must_equal "foo"
  end

  it "#block" do
    subject.block.call.must_equal "bar"
  end
end
