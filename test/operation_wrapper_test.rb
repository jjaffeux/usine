require 'test_helper'

describe Usine::OperationWrapper do
  before do
    Usine.operations = []
  end

  subject {
    Usine::OperationWrapper.new(:call, Item::Create, item: {title: "ALT TITLE"})
  }

  describe "an operation factory is defined" do
    it "#process" do
      Usine.operation(Item::Create) { item }

      operation = subject.process
      model = operation.model

      model.title.must_equal("ALT TITLE")
    end
  end

  describe "an operation factory is not defined" do
    it "#process" do
      proc {
        subject.process
      }.must_raise(ArgumentError)
    end
  end
end
