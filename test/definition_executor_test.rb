require 'test_helper'

describe "DefinitionExecutorTest" do
  let(:block) {
    Proc.new { title { "DEFAULT_TITLE" } }
  }

  subject { Usine::DefinitionExecutor.new }

  describe "when executing a block" do
    it "should set fields" do
      subject.execute(block)

      subject.fields.must_equal(title: "DEFAULT_TITLE")
    end
  end
end
