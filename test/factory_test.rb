require 'test_helper'

describe "FactoryTest" do
  subject { Usine::Factory}

  describe "when initialized with the constructor" do
    it "#new" do
      factory = subject.new(:run, Item::Create)

      factory.mode.must_equal(:run)
      factory.operation.must_equal(Item::Create)
    end

    it "#merged_params" do
      factory = subject.new(:run, Item::Create, title: "another title")

      factory.merged_params.must_equal(title: "another title")
    end
  end
end
