require 'test_helper'

describe "FactoryEvaluatorTest" do
  let(:factory) {
    Usine::Factory.new(Item::Create) do
      item
    end
  }

  let(:definition) {
    Usine::Definition.new(:item) do
      title { "DEFAULT_TITLE" }
    end
  }

  subject {
    evaluator = Usine::FactoryEvaluator.new(factory, :call)
    evaluator.definitions = [definition]
    evaluator
  }

  it "#use" do
    subject
      .use(:item)
      .must_equal(title: "DEFAULT_TITLE")
  end

  it "#process!" do
    operation = subject.process!
    title = operation.model.title

    title.must_equal("DEFAULT_TITLE")
  end

  it "raises if no definition found" do
    proc {
      subject.use(:something)
    }.must_raise(UsineError::DefinitionNotFound)
  end

  # it "finds a defnition for each attribute" do
  #   evaluator = Usine::FactoryEvaluator.new
  #   definition = Usine::Factory.new("xxx") do
  #     title
  #     subtitle { "DEFAULT_SUBTITLE" }
  #   end
  #   evaluator.instance_eval(&definition.block)
  #
  #   evaluator.attributes[:title].must_equal "DEFAULT_TITLE"
  #   evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE"
  # end
  #
  # describe "no block provided for an attribute" do
  #   describe "global sequence exists" do
  #     it "uses #generate with the attribute as default key" do
  #       sequences = [
  #         Usine::Sequence.new(:subtitle) {|n| "DEFAULT_SUBTITLE_#{n}" }
  #       ]
  #       evaluator = Usine::FactoryEvaluator.new(sequences)
  #       definition = Usine::Factory.new("xxx") do
  #         subtitle
  #       end
  #       evaluator.instance_eval(&definition.block)
  #
  #       evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE_1"
  #     end
  #   end
  #
  #   describe "inline sequence exists" do
  #     it "uses #generate with the attribute as default key" do
  #       evaluator = Usine::FactoryEvaluator.new
  #       definition = Usine::Factory.new("xxx") do
  #         sequence(:subtitle)  {|n| "DEFAULT_SUBTITLE_#{n}" }
  #         subtitle
  #       end
  #       evaluator.instance_eval(&definition.block)
  #
  #       evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE_1"
  #     end
  #   end
  #
  #   describe "no sequence for this attribute" do
  #     it "raises an error" do
  #       evaluator = Usine::FactoryEvaluator.new
  #       definition = Usine::Factory.new("xxx") do
  #         subtitle
  #       end
  #
  #       proc {
  #         evaluator.instance_eval(&definition.block)
  #       }.must_raise UsineError::SequenceNotFound
  #     end
  #   end
  # end
end
