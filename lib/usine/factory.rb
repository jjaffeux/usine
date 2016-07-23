module Usine
  class Factory
    attr_reader :operation
    attr_reader :attributes
    attr_reader :block

    def initialize(operation, attributes = {}, &block)
      @operation = operation
      @attributes = attributes
      @block = block
    end
  end
end
