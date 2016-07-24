module Usine
  class OperationWrapper
    def initialize(mode, operation, attributes = {})
      @mode = mode
      @operation = operation
      @operation_factory = find_operation_factory(operation)
      @attributes = attributes
      @factory_attributes = {}
    end

    def operations=(operations)
      @operations = operations
    end

    def operations
      @operations ||= Usine.operations
    end

    def self.call(mode, operation, attributes = {})
      wrapper = new(mode, operation, attributes)
      wrapper.process
    end

    def process
      self.instance_eval(&@operation_factory.block)
      merged_attributes = Utils.merge_hashes(@factory_attributes, @attributes)
      @operation.send(@mode, merged_attributes)
    end

    def method_missing(method_symbol, factory_name = nil, attributes = {}, &block)
      if factory_name
        case factory_name
        when Symbol, String
          @factory_attributes[method_symbol] = attributes_for_factory_name(factory_name)
        else
          merged_attributes = Utils.merge_hashes(attributes, @attributes)
          @factory_attributes[method_symbol] = factory_name.call(merged_attributes).model
        end
      else
        @factory_attributes[method_symbol] = attributes_for_factory_name(method_symbol)
      end
    end

    protected

    def attributes_for_factory_name(name)
      factory = FactoryGirl.factory_by_name(name)
      factory.run(FactoryGirl::Strategy::AttributesFor, {})
    end

    def find_operation_factory(operation_class)
      operation_factory = operations.detect do |op|
        op.operation_class == operation_class
      end

      unless operation_factory
        message = <<-MSG
Couldn’t find an operation factory for: #{operation_class}

Please define it with:
Usine.operation(#{operation_class}) {}
MSG
        raise(ArgumentError::NotFoundOperationFactory, message)
      end

      operation_factory
    end
  end
end
