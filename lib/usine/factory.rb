module Usine
  class Factory
    def self.call(mode, operation, params = {})
      factory = new(mode, operation, params = {})
      factory.process!
    end

    def initialize(mode, operation, params = {})
      @mode = mode
      @operation = operation
      @params = params
      @definition = execute_definition
    end

    def process!
      @operation.send(@mode, @params.merge(@definition.fields))
    end

    protected

    def find_definition
      Usine.definitions.fetch(@operation.to_s, nil)
    end

    def execute_definition
      unless definition_block = find_definition
        raise UsineError::DefinitionNotFound, "No definition found for `#{@operation}`"
      end

      executor = DefinitionExecutor.new
      executor.execute(definition_block)
      executor
    end
  end
end
