module Usine
  class FactoryEvaluator
    attr_reader :mode
    attr_reader :attributes
    attr_reader :generated_attributes
    attr_reader :factory

    def self.call(factory, mode, attributes = {})
      factory = new(factory, mode, attributes)
      factory.process!
    end

    def definitions=(definitions)
      @definitions = definitions
    end

    def definitions
      @definitions ||= Usine.definitions
    end

    def sequences=(sequences)
      @sequences = sequences
    end

    def sequences
      @sequences ||= Usine.sequences
    end

    def initialize(factory, mode, attributes = {})
      @mode = mode
      @factory = factory
      @attributes = attributes
      @generated_attributes = {}
    end

    def use(definition_name, *args)
      definition = definitions.detect do |definition|
        definition.name == definition_name
      end

      if definition.nil?
        message = <<-MSG
Couldn’t find a definition named: #{definition_name}
Available definitions: #{definitions.map(&:name).join(',')}
MSG
        raise(UsineError::DefinitionNotFound, message)
      end

      evaluated_definition = DefinitionEvaluator.new(sequences)
      evaluated_definition.instance_eval(&definition.block)
      evaluated_definition.attributes
    end

    def method_missing(method_symbol, *args, &block)
      if block
        @generated_attributes[method_symbol] = self.instance_eval(&block)
      else
        @generated_attributes[method_symbol] = use(method_symbol, *args)
      end
    end

    def process!
      self.instance_eval(&factory.block)
      @factory.operation.send(@mode, merged_attributes)
    end

    protected

    def merged_attributes
      Utils.merge_hashes(@generated_attributes, @attributes)
    end
  end
end
