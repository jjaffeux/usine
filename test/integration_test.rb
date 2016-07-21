require 'test_helper'

describe "IntegrationTest" do
  describe "callable" do
    it ".call" do
      operation = Usine.run(Item::Create)
      operation.model.title.must_equal "DEFAULT_TITLE"
    end
  end

  describe "runnable" do
    it ".run" do
      operation = Usine.run(Item::Create)
      operation.model.title.must_equal "DEFAULT_TITLE"
    end
  end

  describe "presentable" do
    it ".present" do
      operation = Usine.run(Item::Create)
      operation.model.title.must_equal "DEFAULT_TITLE"
    end
  end

  describe "definition creation" do
    it ".define" do
      class Item::Delete < Item::Create; end
      Usine.define(Item::Delete) do
        subtitle { "Untold story" }
      end

      operation = Usine.(Item::Delete)
      operation.model.subtitle.must_equal "Untold story"
    end

    it "can be extended with other blocks" do
      SendableDefinition = proc {
        valid { false }
      }

      AltTitleDefinition = proc {
        title { "ALT_DEFAULT_TITLE" }
      }

      class Item::Delete < Item::Create; end
      Usine.define(Item::Delete, SendableDefinition, AltTitleDefinition) do
        subtitle { "Untold story" }
      end

      operation = Usine.(Item::Delete)

      operation.model.valid.must_equal false
      operation.model.subtitle.must_equal "Untold story"
      operation.model.title.must_equal "ALT_DEFAULT_TITLE"
    end
  end

  describe "when the definition is not found" do
    it "raises an error" do
      proc {
        Usine.(Item::Update)
      }.must_raise(UsineError::DefinitionNotFound)
    end
  end
end
