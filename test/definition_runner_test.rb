require 'test_helper'

describe "DefinitionRunnerTest" do
  let(:block) {
    Proc.new { title { "DEFAULT_TITLE" } }
  }

  subject { Usine::DefinitionRunner.new }

  describe "when running a block" do
    it "sets fields" do
      subject.run(block)

      subject.fields.must_equal(title: "DEFAULT_TITLE")
    end
  end
end
