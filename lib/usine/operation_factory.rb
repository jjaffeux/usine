module Usine
  class OperationFactory
    attr_reader :operation_class
    attr_reader :block

    def initialize(operation_class, &block)
      @operation_class = operation_class
      @block = block
    end
  end
end
