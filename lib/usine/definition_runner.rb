module Usine
  class DefinitionRunner
    attr_reader :fields

    def initialize
      @fields = {}
    end

    def run(definition_block)
      self.instance_eval(&definition_block)
    end

    def method_missing(method_sym, *arguments, &block)
      @fields[method_sym] = block.call
    end
  end
end