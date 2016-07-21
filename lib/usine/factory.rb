module Usine
  class Factory
    attr_reader :mode
    attr_reader :operation
    attr_reader :params

    def self.call(mode, operation, params = {}, definitions = Usine.definitions)
      factory = new(mode, operation, params, definitions)
      factory.process!
    end

    def initialize(mode, operation, params = {}, definitions = Usine.definitions)
      @mode = mode
      @operation = operation
      @params = params || {}
      @definitions = definitions
      @definition = run_definition
    end

    def process!
      @operation.send(@mode, merged_params)
    end

    def merged_params
      @definition.fields.merge(@params)
    end

    protected

    def run_definition
      unless definition_blocks = find_definitions
        raise UsineError::DefinitionNotFound, "No definition found for `#{@operation}`"
      end
      run_definition_blocks(definition_blocks)
    end

    def find_definitions
      @definitions.fetch(@operation.to_s, nil)
    end

    def run_definition_blocks(definition_blocks)
      runner = DefinitionRunner.new
      definition_blocks.each do |definition_block|
        runner.run(definition_block)
      end
      runner
    end
  end
end
