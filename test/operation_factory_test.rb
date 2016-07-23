require 'test_helper'

describe Usine::OperationFactory do
  before do
    Usine.operations = []
  end

  describe "a factory is defined" do
    subject { Usine::OperationFactory.new(Item::Create) { item } }

    it "#process" do
      subject.process.must_equal(item: {title: "DEFAULT TITLE"})
    end
  end

  describe "a factory is not defined" do
    subject { Usine::OperationFactory.new(Item::Create) { x } }

    it "#process" do
      proc {
        subject.process
      }.must_raise(ArgumentError)
    end
  end
end
