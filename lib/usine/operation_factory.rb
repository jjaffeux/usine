module Usine
  class OperationFactory
    attr_reader :operation_class

    def initialize(operation_class, &block)
      @operation_class = operation_class
      @block = block
      @attributes = {}
    end

    def process
      self.instance_eval(&@block)
      @attributes
    end

    def method_missing(method_symbol, factory_name = nil, &block)
      if factory_name
        @attributes[method_symbol] = attributes_for_factory_name(factory_name)
      else
        @attributes[method_symbol] = attributes_for_factory_name(method_symbol)
      end
    end

    protected

    def attributes_for_factory_name(name)
      factory = FactoryGirl.factory_by_name(name)
      factory.run(FactoryGirl::Strategy::AttributesFor, {})
    end
  end
end
