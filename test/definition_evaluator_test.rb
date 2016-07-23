require 'test_helper'

describe "DefinitionEvaluatorTest" do
  it "adds each attribute to the evaluator" do
    evaluator = Usine::DefinitionEvaluator.new
    definition = Usine::Definition.new("xxx") do
      title    { "DEFAULT_TITLE" }
      subtitle { "DEFAULT_SUBTITLE" }
    end
    evaluator.instance_eval(&definition.block)

    evaluator.attributes[:title].must_equal "DEFAULT_TITLE"
    evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE"
  end

  describe "no block provided for an attribute" do
    describe "global sequence exists" do
      it "uses #generate with the attribute as default key" do
        sequences = [
          Usine::Sequence.new(:subtitle) {|n| "DEFAULT_SUBTITLE_#{n}" }
        ]
        evaluator = Usine::DefinitionEvaluator.new(sequences)
        definition = Usine::Definition.new("xxx") do
          subtitle
        end
        evaluator.instance_eval(&definition.block)

        evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE_1"
      end
    end

    describe "inline sequence exists" do
      it "uses #generate with the attribute as default key" do
        evaluator = Usine::DefinitionEvaluator.new
        definition = Usine::Definition.new("xxx") do
          sequence(:subtitle)  {|n| "DEFAULT_SUBTITLE_#{n}" }
          subtitle
        end
        evaluator.instance_eval(&definition.block)

        evaluator.attributes[:subtitle].must_equal "DEFAULT_SUBTITLE_1"
      end
    end

    describe "no sequence for this attribute" do
      it "raises an error" do
        evaluator = Usine::DefinitionEvaluator.new
        definition = Usine::Definition.new("xxx") do
          subtitle
        end

        proc {
          evaluator.instance_eval(&definition.block)
        }.must_raise(UsineError::SequenceNotFound)
      end
    end
  end
end
