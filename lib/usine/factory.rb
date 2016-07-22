module Usine
  class Factory
    attr_reader :mode
    attr_reader :operation
    attr_reader :attributes
    attr_accessor :definition

    def self.call(mode, operation, attributes = {})
      factory = new(mode, operation, attributes, definitions)
      factory.process!
    end

    def initialize(mode, operation, attributes = {})
      @mode = mode
      @operation = operation
      @definitions = attributes.delete(:definitions) || Usine.definitions.fetch(operation, [])
      @sequences = attributes.delete(:sequences) || Usine.sequences
      @attributes = attributes || {}
    end

    def process!
      @operation.send(@mode, merged_attributes)
    end

    def merged_attributes
      evaluated_factory.attributes.merge(@attributes)
    end

    def evaluated_factory
      @evaluated_factory ||= evaluate_with_definitions(@sequences)
    end

    protected

    def filtered_definitions
      filtered = @definitions.select do |definition|
        definition.name == @operation
      end

      if filtered.empty?
        raise UsineError::DefinitionNotFound, "No definition found for `#{@operation}`"
      end

      filtered
    end

    def evaluate_with_definitions(sequences)
      evaluator = Evaluator.new(sequences)
      filtered_definitions.each do |definition|
        evaluator.instance_eval(&definition.block)
      end
      evaluator
    end
  end
end
