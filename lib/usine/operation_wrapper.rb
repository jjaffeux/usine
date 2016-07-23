module Usine
  class OperationWrapper
    def initialize(mode, operation, attributes = {})
      @mode = mode
      @operation = operation
      @operation_factory = find_operation_factory(operation)
      @attributes = attributes
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
      factory_attributes = @operation_factory.process
      merged_attributes = Utils.merge_hashes(factory_attributes, @attributes)
      @operation.send(@mode, merged_attributes)
    end

    protected

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
        raise(ArgumentError, message)
      end

      operation_factory
    end
  end
end
